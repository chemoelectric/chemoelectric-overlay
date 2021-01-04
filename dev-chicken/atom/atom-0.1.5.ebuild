# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Atom 1.0 feed reader and writer"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/matchable:=
	dev-chicken/ssax:=
	>=dev-chicken/sxml-serializer-0.2:=
	dev-chicken/regex:=
"
DEPEND="${RDEPEND}"
