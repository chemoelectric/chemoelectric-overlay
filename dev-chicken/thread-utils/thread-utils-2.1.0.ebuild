# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Thread Utilities"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/queues-0.1:=
	>=dev-chicken/srfi1-0.5.1:=
	>=dev-chicken/srfi18-0.1.5:=
	>=dev-chicken/miscmacros-1.0:=
	>=dev-chicken/record-variants-1.1:=
	>=dev-chicken/synch-3.2.1:=
	>=dev-chicken/check-errors-3.1.1:=
"
DEPEND="${RDEPEND}"
