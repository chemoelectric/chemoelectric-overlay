# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Chicken bindings to the ICU unicode library"

LICENSE="unicode"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/icu:=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/utf8:=
	dev-chicken/srfi13:=
	dev-chicken/srfi1:=
	dev-chicken/foreigners:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	${RDEPEND}
	>=dev-chicken/chalk-0.3.5-r1
"
