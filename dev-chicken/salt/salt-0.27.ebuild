# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Hybrid dynamical systems modeling"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/datatype:=
	dev-chicken/matchable:=
	dev-chicken/make:=
	dev-chicken/mathh:=
	dev-chicken/lalr:=
	dev-chicken/datatype:=
	dev-chicken/unitconv:=
	dev-chicken/fmt:=
"
DEPEND="${RDEPEND}"
