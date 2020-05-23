# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="URI generic syntax (RFC 3986) parsing and manipulation"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/matchable:=
	dev-chicken/srfi1:=
	dev-chicken/srfi14:=
"
DEPEND="${RDEPEND}"
