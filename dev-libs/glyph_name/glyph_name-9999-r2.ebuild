# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
DEPEND=""
BDEPEND="
	dev-util/scons:*
	>=dev-lang/python-3:*
	sys-devel/m4:*
"

S="${WORKDIR}/${PN}-${PV}"

src_compile() {
	scons --include_soname || die
}

src_install() {
	scons --prefix="${D}/usr" --libdir="${D}/usr/$(get_libdir)" --include_soname install || die
}
