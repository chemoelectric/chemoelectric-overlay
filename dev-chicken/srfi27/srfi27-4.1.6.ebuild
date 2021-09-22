# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Sources of Random Bits"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc3:=
	dev-chicken/srfi1:=
	dev-chicken/check-errors:=
	dev-chicken/timed-resource:=
	dev-chicken/miscmacros:=
	dev-chicken/vector-lib:=
"
DEPEND="${RDEPEND}"
