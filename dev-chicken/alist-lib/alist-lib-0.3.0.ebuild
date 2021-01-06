# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="SRFI-69-like library for alists"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/hahn-0.9.3:=
	dev-chicken/matchable:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
