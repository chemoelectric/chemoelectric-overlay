# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Bindings to version 3.x of the SQLite API"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
	dev-chicken/object-evict:=
	dev-chicken/check-errors:=
	dev-chicken/synch:=
	dev-chicken/miscmacros:=
	dev-chicken/matchable:=
	dev-chicken/sql-null:=
	dev-db/sqlite:3=
"
DEPEND="${RDEPEND}"
