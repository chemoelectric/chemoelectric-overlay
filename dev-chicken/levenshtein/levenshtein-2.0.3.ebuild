# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Levenshtein edit distance"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/srfi1-0.5.1:=
	>=dev-chicken/srfi13-0.3:=
	>=dev-chicken/srfi63-0.5:=
	>=dev-chicken/srfi69-0.4.1:=
	>=dev-chicken/vector-lib-2.1.1:=
	>=dev-chicken/utf8-3.6.2:=
	>=dev-chicken/check-errors-3.1.2:=
	>=dev-chicken/miscmacros-1.0:=
	>=dev-chicken/moremacros-2.2.1:=
"
DEPEND="${RDEPEND}"
