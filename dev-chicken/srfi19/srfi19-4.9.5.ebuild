# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Time Data Types and Procedures"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/utf8:=
	dev-chicken/srfi18:=
	dev-chicken/srfi29:=
	dev-chicken/miscmacros:=
	dev-chicken/locale:=
	dev-chicken/record-variants:=
	>=dev-chicken/check-errors-3.6.0:=
"
DEPEND="${RDEPEND}"