# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Localization"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/utf8-3.6.2:=
	>=dev-chicken/srfi1-0.5.1:=
	>=dev-chicken/srfi69-0.4.1:=
	>=dev-chicken/miscmacros-1.0:=
	>=dev-chicken/moremacros-2.1.0:=
	>=dev-chicken/locale-0.8.1:=
	>=dev-chicken/posix-utils-2.0.0:=
	>=dev-chicken/condition-utils-2.1.0:=
	>=dev-chicken/check-errors-3.1.1:=
"
DEPEND="${RDEPEND}"
