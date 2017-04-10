# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit pure-lang

DESCRIPTION="OpenGL module for Pure"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-lang/pure
	media-libs/freeglut
	virtual/opengl
"
RDEPEND="${DEPEND}"
