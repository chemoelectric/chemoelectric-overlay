# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pure-lang eutils

DESCRIPTION="C interface/module generator for Pure"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT=strip

RDEPEND=">=dev-lang/pure-0.57"
DEPEND="
	${RDEPEND}
	>=dev-lang/ghc-7.6.3-r1
	>=dev-haskell/language-c-0.4.2
"
