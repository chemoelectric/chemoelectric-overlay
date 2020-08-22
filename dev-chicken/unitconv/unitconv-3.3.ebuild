# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Conversion of units of measurement"

LICENSE="LGPL-3"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/datatype:=
	dev-chicken/matchable:=
"
DEPEND="${RDEPEND}"
