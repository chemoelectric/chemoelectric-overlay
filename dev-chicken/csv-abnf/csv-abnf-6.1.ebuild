# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Parsing and formatting of comma-separated values (CSV)"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/regex:=
	dev-chicken/utf8:=
	dev-chicken/abnf:=
	dev-chicken/yasos:=
"
DEPEND="${RDEPEND}"
