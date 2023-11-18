# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mercurial
inherit toolchain-funcs
inherit chicken-egg

DESCRIPTION="Count bits in a fixnum"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/bit-counting"
SRC_URI=""
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="GPL-3+"
SLOT="0/0"
KEYWORDS=""

IUSE=""

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/r7rs
"
DEPEND="
	${RDEPEND}
"

PATCHES=(
	"${FILESDIR}"/csc-options.patch
)

src_prepare() {
	chicken-egg_src_prepare
	sed -i -e "s|%MY_CC%|$(my_cc)|g" "${PN}".egg || die
}

my_cc() {
	# Use the user’s CFLAGS, in case they have such flags as
	# -march=native or -mpopcnt.
	echo "$(tc-getCC) ${CFLAGS}" || die
}
