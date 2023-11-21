# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="JavaScript Object Notation (JSON) parser and printer"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/r7rs:=
	dev-chicken/srfi60:=
	dev-chicken/srfi145:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/srfi121:=
"
