# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Bindings to Google's LevelDB Key-Value Store"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/leveldb:=
	>=dev-scheme/chicken-5.3.0:=
"
DEPEND="${RDEPEND}"
