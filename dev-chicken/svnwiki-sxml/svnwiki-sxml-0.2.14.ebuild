# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Parse svnwiki to sxml"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/matchable:=
	dev-chicken/html-parser:=
	dev-chicken/sxml-transforms:=
	dev-chicken/srfi13:=
	dev-chicken/srfi1:=
	dev-chicken/regex:=
"
DEPEND="${RDEPEND}"
