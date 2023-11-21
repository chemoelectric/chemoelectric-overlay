# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Simple, cancel-able, efficient timer API"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi18:=
	dev-chicken/pigeon-hole:=
	dev-chicken/llrb-tree:=
"
DEPEND="${RDEPEND}"
