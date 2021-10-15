# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Thread Utilities"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc4:=
	dev-chicken/queues:=
	dev-chicken/srfi1:=
	dev-chicken/srfi18:=
	dev-chicken/check-errors:=
	dev-chicken/miscmacros:=
	dev-chicken/record-variants:=
	>=dev-chicken/synch-3.2.1:=
"
DEPEND="${RDEPEND}"
