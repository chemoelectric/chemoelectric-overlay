# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Localization"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi69:=
	dev-chicken/utf8:=
	dev-chicken/locale:=
	dev-chicken/posix-utils:=
	dev-chicken/condition-utils:=
	>=dev-chicken/check-errors-3.6.0:=
"
DEPEND="${RDEPEND}"