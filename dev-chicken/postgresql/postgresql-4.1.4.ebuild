# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings for PostgreSQL's C-api"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/postgresql:=
	>=dev-scheme/chicken-5.3.0_rc4:=
	dev-chicken/sql-null:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
