# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Disjoint set implementation based on Scheme vectors and their indexes"

LICENSE="Unlicense"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
"
DEPEND="${RDEPEND}"
