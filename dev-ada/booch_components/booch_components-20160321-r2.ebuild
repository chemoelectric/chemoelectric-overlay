# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing

DESCRIPTION="Booch Components for Ada"
HOMEPAGE="http://booch95.sourceforge.net/"
SRC_URI="mirror://sourceforge/booch95/bc-${PV}.tgz"
LICENSE="GPL-2+"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples"

RDEPEND="virtual/ada:*"
DEPEND="
	${RDEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900:*
"

S="${WORKDIR}/bc-${PV}"

PATCHES=( "${FILESDIR}/bc-${PV}.patch" )

src_configure() {
	sed -e 's:@PREFIX@:/usr:' \
		-e 's:@LIBDIR@:'"$(get_libdir)"':' \
		-e 's:@PROCESSORS@:'"$(makeopts_jobs)"':' \
		Makefile.in > Makefile || die
}

src_install() {
	emake install LIBDIR="$(get_libdir)" DESTDIR="${D}"
	einstalldocs

	# The "INSTALL" file also serves as a README file for this project.
	dodoc INSTALL

	use examples && {
		dodoc -r contrib
		mv "${D}"/usr/share/doc/"${PF}"/{contrib,examples} || die
	}
}
