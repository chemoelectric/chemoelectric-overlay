# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Utilities for getopt-long"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/utf8:=
	dev-chicken/srfi1:=
	dev-chicken/getopt-long:=
"
DEPEND="${RDEPEND}"
