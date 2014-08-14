# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

DESCRIPTION="Booch Components for Ada"
HOMEPAGE="http://booch95.sourceforge.net/"
SRC_URI="mirror://sourceforge/booch95/bc-${PVR}.tgz"
LICENSE="GPL-2+"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-devel/gcc[ada]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/bc-${PVR}"

src_prepare() {
	sed -i -e "s|../../lib/bc/lib-|../../$(get_libdir)/bc/lib-|" \
		bc.gpr-for-installation
}

src_configure() {
	sed -e 's|\$(prefix)/lib|\$(libdir)|g' Makefile.in > Makefile \
		|| die "creation of Makefile failed"
}

src_compile() {
	emake GPRBUILD="gnatmake ${GNATMAKEFLAGS}" \
		tcprefix=/usr libdir=/usr/"$(get_libdir)"
}

src_install() {
	emake install prefix="${D}"usr libdir="${D}"usr/"$(get_libdir)"

	# INSTALL is the file provided that most resembles a README.
	dodoc INSTALL
}
