# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A simple 2D and 3D graphics library for X11"

LICENSE="LGPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/libX11:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/bind:=
"
DEPEND="${RDEPEND}"
