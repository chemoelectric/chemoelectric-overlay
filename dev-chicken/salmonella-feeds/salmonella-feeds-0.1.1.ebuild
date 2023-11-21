# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A tool to generate atom feeds out of salmonella log files"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/atom:=
	dev-chicken/rfc3339:=
	dev-chicken/salmonella:=
	>=dev-chicken/salmonella-diff-1.1:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
