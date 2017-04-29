# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing git-r3

DESCRIPTION="XML parser for Ada95"
HOMEPAGE="http://libre.adacore.com"
EGIT_REPO_URI="https://github.com/AdaCore/${PN}.git"

LICENSE="GPL-3+ gcc-runtime-library-exception-3.1"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="virtual/ada:*"
DEPEND="
	${RDEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900:*
	doc? ( dev-python/sphinx:*[latex] )
"

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
