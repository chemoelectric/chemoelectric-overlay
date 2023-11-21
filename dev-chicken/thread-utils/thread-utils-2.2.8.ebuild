# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Thread Utilities"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/queues:=
	dev-chicken/srfi1:=
	dev-chicken/srfi18:=
	dev-chicken/miscmacros:=
	dev-chicken/moremacros:=
	dev-chicken/record-variants:=
	>=dev-chicken/check-errors-3.5.0:=
	>=dev-chicken/synch-3.2.1:=
"
DEPEND="${RDEPEND}"
