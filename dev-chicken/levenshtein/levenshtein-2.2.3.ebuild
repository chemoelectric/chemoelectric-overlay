# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Levenshtein edit distance"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi63:=
	dev-chicken/srfi69:=
	dev-chicken/vector-lib:=
	dev-chicken/utf8:=
	dev-chicken/check-errors:=
	dev-chicken/miscmacros:=
	dev-chicken/record-variants:=
"
DEPEND="${RDEPEND}"
