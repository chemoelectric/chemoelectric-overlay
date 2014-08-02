# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pure-lang

DESCRIPTION="Embed GNU Octave in Pure"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-lang/pure
	sci-mathematics/octave
"
RDEPEND="${DEPEND}"