# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Schemely parser combinators"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/lazy-seq-0.1.0:=
	dev-chicken/trie:=
	dev-chicken/matchable:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi14:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
