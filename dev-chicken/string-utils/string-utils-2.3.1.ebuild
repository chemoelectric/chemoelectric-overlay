# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="String Utilities"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/srfi1-0.1:=
	>=dev-chicken/srfi13-0.1:=
	>=dev-chicken/srfi69-0.1:=
	>=dev-chicken/miscmacros-1.0:=
	>=dev-chicken/utf8-3.5.0:=
	>=dev-chicken/check-errors-2.0.0:=
"
DEPEND="${RDEPEND}"
