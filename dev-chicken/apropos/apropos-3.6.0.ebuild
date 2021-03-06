# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="CHICKEN apropos"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/check-errors:=
	>=dev-chicken/string-utils-2.1.1:=
	>=dev-chicken/symbol-utils-2.0.2:=
"
DEPEND="${RDEPEND}"
