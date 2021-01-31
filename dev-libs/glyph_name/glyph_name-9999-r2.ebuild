# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8,9} )
DISTUTILS_USE_SETUPTOOLS=no

inherit git-r3

IUSE=""

DESCRIPTION="A library for computing Unicode sequences from glyph names"
HOMEPAGE="https://bitbucket.org/chemoelectric/glyph_name"
SRC_URI=""
EGIT_REPO_URI="https://chemoelectric@bitbucket.org/chemoelectric/glyph_name.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=""
DEPEND="
	dev-util/scons
	sys-devel/m4
	${RDEPEND}
"

S="${WORKDIR}/${PN}-${PV}"

src_compile() {
	scons --include_soname || die
}

src_install() {
	scons --prefix="${D}/usr" --libdir="${D}/usr/$(get_libdir)" --include_soname install || die
}
