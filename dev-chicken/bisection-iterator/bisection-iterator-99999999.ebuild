# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mercurial
inherit chicken-egg

DESCRIPTION="Constant-space iterators for bisection intervals"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/bisection-iterator"
SRC_URI=""
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="BSD"
SLOT="0/0"
KEYWORDS=""

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/r7rs:=
"
DEPEND="${RDEPEND}"

src_compile() {
	local emakeflags="CSI=/usr/bin/chicken-csi CSC=/usr/bin/chicken-csc"

	# Possibly speed things up, by compiling with the GNUmakefile
	# (which can do parallel builds) instead of with chicken-install.
	emake ${emakeflags}
}
