# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Invoke callbacks from other native threads"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/typed-records:=
	dev-chicken/matchable:=
	dev-chicken/bind:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
