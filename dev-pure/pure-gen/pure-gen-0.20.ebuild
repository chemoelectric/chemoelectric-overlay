# Copyright 1999-2015 Gentoo Foundation
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

RDEPEND="dev-lang/pure"
DEPEND="
	${RDEPEND}
	dev-lang/ghc
	dev-haskell/language-c
"
