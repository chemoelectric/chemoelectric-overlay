# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings to the GLFW3 OpenGL window and event management library"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	=media-libs/glfw-3*:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/bind:=
"
DEPEND="${RDEPEND}"
