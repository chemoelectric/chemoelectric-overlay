# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Bindings to OpenGL and OpenGL ES through the Epoxy library"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/libepoxy:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/bind:=
"
DEPEND="${RDEPEND}"
