# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Automatically generate bindings from C/C++ declarations"

LICENSE="public-domain"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/silex:=
	dev-chicken/matchable:=
	dev-chicken/coops:=
	dev-chicken/srfi1:=
	dev-chicken/regex:=
"
DEPEND="${RDEPEND}"
