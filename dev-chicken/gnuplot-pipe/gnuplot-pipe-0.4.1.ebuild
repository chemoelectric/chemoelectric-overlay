# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A simple interface to Gnuplot"

LICENSE="GPL-3"
SLOT="0/5"
KEYWORDS="~amd64"

COMMON_DEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	>=sci-visualization/gnuplot-5.2:*
	${COMMON_DEPEND}
"
