# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Automatically generate bindings from C/C++ declarations"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/silex:=
	dev-chicken/matchable:=
	dev-chicken/coops:=
	dev-chicken/srfi1:=
	dev-chicken/regex:=
"
DEPEND="${RDEPEND}"
