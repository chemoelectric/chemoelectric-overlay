# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Sources of Random Bits"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/vector-lib:=
	dev-chicken/timed-resource:=
	dev-chicken/miscmacros:=
	>=dev-chicken/check-errors-3.6.0:=
"
DEPEND="${RDEPEND}"
