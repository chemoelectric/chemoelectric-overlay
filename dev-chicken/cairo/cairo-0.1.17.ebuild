# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Chicken bindings for Cairo, a vector graphics library"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/cairo:=
	>=dev-scheme/chicken-5.3.0:=
"
DEPEND="${RDEPEND}"
