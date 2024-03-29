# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Command-line argument handling, on top of SRFI 37"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc2:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi37:=
"
DEPEND="${RDEPEND}"
