# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Bindings to LMDB"

LICENSE="OPENLDAP"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/lmdb:=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
