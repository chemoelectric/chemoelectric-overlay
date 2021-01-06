# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="SRFI 146: Mappings"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/hash-trie:=
	dev-chicken/srfi1:=
	dev-chicken/srfi128:=
	dev-chicken/srfi145:=
	dev-chicken/srfi158:=
"
DEPEND="${RDEPEND}"
