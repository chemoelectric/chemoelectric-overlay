# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Time Data Types and Procedures"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/srfi1-0.5.1:=
	>=dev-chicken/srfi13-0.3:=
	>=dev-chicken/srfi18-0.1.5:=
	>=dev-chicken/srfi69-0.4.1:=
	>=dev-chicken/miscmacros-1.0:=
	>=dev-chicken/locale-0.8.1:=
	>=dev-chicken/srfi29-3.0.0:=
	>=dev-chicken/record-variants-1.1:=
	>=dev-chicken/check-errors-3.1.1:=
"
DEPEND="${RDEPEND}"
