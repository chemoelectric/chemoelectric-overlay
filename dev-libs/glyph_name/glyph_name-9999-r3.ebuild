# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
inherit autotools

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
	>=dev-lang/python-3:*
	sys-devel/m4:*
"

src_prepare() {
	default
	eautoreconf
}
