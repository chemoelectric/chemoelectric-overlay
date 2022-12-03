# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools
inherit mercurial

DESCRIPTION="Wrapper scripts for D compilers to make them more like a C compiler"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/dlangc"
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/dlangc"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-alternatives/awk"
DEPEND=""

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf AWK_COMMAND="${DLANGC_AWK_COMMAND-/bin/awk -f}"
}
