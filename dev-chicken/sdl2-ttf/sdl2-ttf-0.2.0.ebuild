# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings to SDL_ttf 2"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/sdl2-ttf:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/sdl2:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
