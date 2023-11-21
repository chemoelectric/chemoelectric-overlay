# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Bindings to Facebooks's RocksDB Key-Value Store"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/rocksdb:=
	>=dev-scheme/chicken-5.2.0:=
"
DEPEND="${RDEPEND}"
