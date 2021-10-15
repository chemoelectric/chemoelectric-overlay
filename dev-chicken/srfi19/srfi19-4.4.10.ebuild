# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Time Data Types and Procedures"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc4:=
	dev-chicken/srfi1:=
	dev-chicken/utf8:=
	dev-chicken/srfi18:=
	dev-chicken/srfi29:=
	dev-chicken/srfi69:=
	dev-chicken/miscmacros:=
	dev-chicken/locale:=
	dev-chicken/record-variants:=
	dev-chicken/check-errors:=
"
DEPEND="${RDEPEND}"
