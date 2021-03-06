# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Resource w/ Timeout"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/record-variants:=
	dev-chicken/check-errors:=
	dev-chicken/thread-utils:=
	dev-chicken/srfi1:=
	dev-chicken/srfi18:=
	dev-chicken/synch:=
	dev-chicken/miscmacros:=
"
DEPEND="${RDEPEND}"
