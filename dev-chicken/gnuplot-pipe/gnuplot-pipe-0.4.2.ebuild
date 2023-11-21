# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A simple interface to Gnuplot"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

COMMON_DEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	sci-visualization/gnuplot:*
	${COMMON_DEPEND}
"
