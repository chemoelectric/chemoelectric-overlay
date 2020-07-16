# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Convert Markdown to svnwiki"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/lowdown:=
	dev-chicken/sxml-transforms:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi37:=
"
DEPEND="${RDEPEND}"
