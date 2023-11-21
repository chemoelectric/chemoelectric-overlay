# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Generate HTML from (svn)wiki SXML"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/regex:=
	dev-chicken/matchable:=
	dev-chicken/sxml-transforms:=
	dev-chicken/colorize:=
	dev-chicken/svnwiki-sxml:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
"
DEPEND="${RDEPEND}"
