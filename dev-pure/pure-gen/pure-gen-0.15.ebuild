# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="C interface/module generator for Pure"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="strip"

RDEPEND=">=dev-lang/pure-0.49"
DEPEND="
    ${RDEPEND}
    >=dev-lang/ghc-7.0.4
    >=dev-haskell/language-c-0.4.1
"

