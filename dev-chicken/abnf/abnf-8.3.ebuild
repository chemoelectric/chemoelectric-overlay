# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Parser combinators for Augmented BNF grammars (RFC 4234)"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc4:=
	dev-chicken/srfi1:=
	dev-chicken/utf8:=
	dev-chicken/lexgen:=
"
DEPEND="${RDEPEND}"
