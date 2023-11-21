# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Tokyo Cabinet hash database interface"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-db/tokyocabinet-1.4.48-r1:=
	>=dev-scheme/chicken-5.2.0:=
"
DEPEND="${RDEPEND}"
