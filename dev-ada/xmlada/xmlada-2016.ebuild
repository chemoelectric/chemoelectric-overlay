# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing

MY_PV="${PN}-gpl-${PV}-src"

DESCRIPTION="XML parser for Ada95"
HOMEPAGE="http://libre.adacore.com"
SRC_URI="http://mirrors.cdn.adacore.com/art/57399978c7a447658e0affc0 -> ${MY_PV}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="virtual/ada:*"
DEPEND="
	${RDEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900:*
	doc? ( dev-python/sphinx:*[latex] )
"

S="${WORKDIR}/${MY_PV}"

HTML_DOCS=""

src_compile() {
	emake -j1 PROCESSORS="$(makeopts_jobs)"
	use doc && emake docs
}

src_install() {
	emake -j1 install prefix="${D}/usr" PROCESSORS="$(makeopts_jobs)"
	einstalldocs
	use doc && {
		rm "${D}/usr/share/doc/${PN}/.buildinfo" || :
		dodir "/usr/share/doc/${PF}"
		mv "${D}/usr/share/doc/${PN}/"*.pdf "${D}/usr/share/doc/${PF}/" || die
		mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}/html" || die
	}
}
