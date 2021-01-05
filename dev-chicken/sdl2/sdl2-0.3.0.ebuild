# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings to Simple DirectMedia Layer 2 (SDL2)"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/libsdl2:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi1:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
