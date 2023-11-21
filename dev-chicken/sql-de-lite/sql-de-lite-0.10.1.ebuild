# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="SQLite 3 interface"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/sqlite:3=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/foreigners:=
	dev-chicken/object-evict:=
	dev-chicken/srfi1:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
