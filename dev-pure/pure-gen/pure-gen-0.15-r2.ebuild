# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit pure-lang eutils

DESCRIPTION="C interface/module generator for Pure"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT=strip

RDEPEND=">=dev-lang/pure-0.56"
DEPEND="
	${RDEPEND}
	>=dev-lang/ghc-7.4.2
	>=dev-haskell/language-c-0.4.2
"

src_prepare() {
	default
	epatch "${FILESDIR}/${P}-Makefile.patch"
}
