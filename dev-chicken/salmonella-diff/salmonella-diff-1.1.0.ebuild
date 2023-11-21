# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A tool to diff salmonella log files"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/salmonella:=
	dev-chicken/salmonella-html-report:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/sxml-transforms:=
"
DEPEND="${RDEPEND}"
