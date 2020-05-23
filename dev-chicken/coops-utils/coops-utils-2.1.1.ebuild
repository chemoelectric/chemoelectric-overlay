# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="coops utilities"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/srfi1-0.1:=
	>=dev-chicken/srfi13-0.1:=
	>=dev-chicken/coops-1.0:=
	>=dev-chicken/check-errors-3.1.0:=
"
DEPEND="${RDEPEND}"
