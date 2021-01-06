# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings to LMDB"

LICENSE="OPENLDAP"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/lmdb:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
