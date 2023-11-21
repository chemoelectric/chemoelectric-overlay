# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A small awful app implementing a pastebin service"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/awful:=
	dev-chicken/awful-sql-de-lite:=
	dev-chicken/simple-sha1:=
	dev-chicken/intarweb:=
	dev-chicken/html-parser:=
	dev-chicken/colorize:=
	dev-chicken/miscmacros:=
	dev-chicken/utf8:=
"
DEPEND="${RDEPEND}"
