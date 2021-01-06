# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial
inherit toolchain-funcs
inherit chicken-egg

DESCRIPTION="Monads for Chicken Scheme"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/${PN}"
SRC_URI=""
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="BSD"
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
