# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Symbolic expression log format for Spiffy"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/spiffy:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
"
DEPEND="${RDEPEND}"
