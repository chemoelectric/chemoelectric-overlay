# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang eutils

DESCRIPTION="C interface/module generator for Pure"
LICENSE="BSD"
SLOT="0"
KEYWORDS="-*"
IUSE=""

RDEPEND=">=dev-lang/pure-0.53"
DEPEND="
    ${RDEPEND}
    >=dev-lang/ghc-7.4.1
    >=dev-haskell/language-c-0.4.1
"

src_prepare() {
	default
	epatch "${FILESDIR}/${P}-Makefile.patch"
}
