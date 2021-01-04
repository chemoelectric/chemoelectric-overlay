# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="qwiki - the quick wiki"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/intarweb:=
	dev-chicken/uri-common:=
	dev-chicken/spiffy:=
	dev-chicken/sxml-transforms:=
	dev-chicken/svn-client:=
	dev-chicken/estraier-client:=
	dev-chicken/sxpath:=
	dev-chicken/simple-sha1:=
	dev-chicken/svnwiki-sxml:=
	dev-chicken/html-parser:=
	dev-chicken/colorize:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi14:=
"
DEPEND="${RDEPEND}"
