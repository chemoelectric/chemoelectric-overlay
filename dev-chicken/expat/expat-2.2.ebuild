# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="An interface to James Clark's Expat XML parser"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/expat:=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/bind:=
	dev-chicken/silex:=
"
DEPEND="${RDEPEND}"
