# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="Embed GNU Octave in Pure"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    >=dev-lang/pure-0.56
    >=sci-mathematics/octave-3.4.3-r1
"
RDEPEND="${DEPEND}"
