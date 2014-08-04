# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.7.4.ebuild,v 1.2 2014/07/31 06:32:24 vapier Exp $

EAPI=5

DESCRIPTION="GCC binary for building GCC stage1"
HOMEPAGE="https://gcc.gnu.org/"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/gnat-bootstrap-4.7-4.7.4.tar.xz"
LICENSE="GPL-3+ LGPL-3+ || ( GPL-3+ libgcc libstdc++ gcc-runtime-library-exception-3.1 ) FDL-1.3+"

KEYWORDS="~amd64"
SLOT="4.7"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	mv opt "${D}" || die

	for f in README-4.7.4 CONFIGURE-gnat-bootstrap-4.7.4.sh
	do
		cp "${FILESDIR}/${f}" . || die
		dodoc "${f}"
	done
}
