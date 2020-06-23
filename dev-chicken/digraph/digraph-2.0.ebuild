# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Directed graph in adjacency list format"

LICENSE="GPL-3"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/dyn-vector:=
	dev-chicken/matchable:=
	dev-chicken/yasos:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
