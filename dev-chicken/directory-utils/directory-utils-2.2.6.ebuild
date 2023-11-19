# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Directory utilities"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/miscmacros:=
	dev-chicken/moremacros:=
	dev-chicken/list-utils:=
	dev-chicken/stack:=
	>=dev-chicken/check-errors-3.5.0:=
"
DEPEND="${RDEPEND}"
