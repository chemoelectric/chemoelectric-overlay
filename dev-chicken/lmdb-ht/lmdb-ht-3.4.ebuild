# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Hashtable-like interface to the LMDB key-value database"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/lmdb:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/rabbit:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/srfi13:=
	dev-chicken/compile-file:=
"
