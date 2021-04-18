# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Generate static HTML manual from wiki docs"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/regex:=
	dev-chicken/matchable:=
	dev-chicken/svnwiki-sxml:=
	dev-chicken/srfi1:=
	dev-chicken/uri-generic:=
	dev-chicken/chicken-doc-html:=
"
DEPEND="${RDEPEND}"
