# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Easily create micro-benchmarks"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc4:=
	>=dev-chicken/micro-stats-0.0.5:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
