# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Visualize sexps as trees via Graphviz"

LICENSE="BSD-1"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/brev-separate:=
	dev-chicken/srfi1:=
	dev-chicken/define-options:=
	dev-chicken/match-generics:=
"
DEPEND="${RDEPEND}"
