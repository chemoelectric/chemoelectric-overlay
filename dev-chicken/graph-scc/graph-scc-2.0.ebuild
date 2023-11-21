# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Compute strongly-connected components (SCC) of a graph"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/queues:=
	dev-chicken/iset:=
	dev-chicken/matchable:=
	dev-chicken/yasos:=
	dev-chicken/digraph:=
"
DEPEND="${RDEPEND}"
