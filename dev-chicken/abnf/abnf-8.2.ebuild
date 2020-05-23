# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Parser combinators for Augmented BNF grammars (RFC 4234)"

LICENSE="GPL-3"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/utf8:=
	dev-chicken/lexgen:=
"
DEPEND="${RDEPEND}"
