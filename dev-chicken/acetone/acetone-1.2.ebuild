# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A simple parser"

LICENSE="BSD-1"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/match-generics:=
	dev-chicken/srfi1:=
	dev-chicken/brev-separate:=
"
DEPEND="${RDEPEND}"
