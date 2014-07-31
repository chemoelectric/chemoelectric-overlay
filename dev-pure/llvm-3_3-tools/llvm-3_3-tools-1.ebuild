# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

DESCRIPTION="A TEMPORARY HACK: Statically linked LLVM 3.3 tools (binaries) for use with Pure and LLVM 3.4"
HOMEPAGE="https://groups.google.com/forum/#!topic/pure-lang/ZiMK5DY9Tq0"
SRC_URI="https://bitbucket.org/purelang/pure-lang/downloads/llvm-3.3-tools.tar.bz2"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=sys-devel/llvm-3.4*"
RDEPEND="${DEPEND}"

S="${WORKDIR}/llvm-3.3-tools"

src_install() {
	dodoc README

	dodir /usr/$(get_libdir)/pure
	insinto /usr/$(get_libdir)/pure
	insopts -m755
	use amd64 && doins x86_64/{llc,opt}
	use x86 && doins i686/{llc,opt}
}
