# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Scheme jq wrapper for processing S-expressions"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/optimism:=
	dev-chicken/r7rs:=
	dev-chicken/simple-exceptions:=
	dev-chicken/srfi18:=
	dev-chicken/srfi60:=
	dev-chicken/srfi145:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/begin-syntax:=
	dev-chicken/matchable:=
	dev-chicken/miscmacros:=
	dev-chicken/module-declarations:=
"
