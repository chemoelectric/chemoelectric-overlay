# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GNU COBOL compiler"
HOMEPAGE="https://gnucobol.sourceforge.io/"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${PN}/$(ver_cut 1-2)/${P}.tar.xz"

LICENSE="GPL-3+ LGPL-3+ FDL-1.3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="berkdb code-coverage ncurses +gmp json mpir nls xml"

RDEPEND="
	gmp? ( dev-libs/gmp:= )
	mpir? ( sci-libs/mpir:= )
	berkdb? ( =sys-libs/db-4*:= )
	code-coverage? ( dev-util/lcov:* )
	xml? ( dev-libs/libxml2:= )
	json? ( dev-libs/json-c:= )
	ncurses? ( sys-libs/ncurses:= )
"
DEPEND="
	${RDEPEND}
	sys-devel/libtool
"

REQUIRED_USE="
	^^ ( gmp mpir )
"

# FIXME: I am restricting test phase, because I do not want to test that
# phase. :)
RESTRICT="test"

# FIXME: Better, if possible, to patch things as not to strip this file.
QA_PRESTRIPPED="
	usr/lib.*/${PN}/CBL_OC_DUMP.so
"

src_configure() {
	local json_with='--with-json=no'
	if use json; then
		json_with='--with-json=json-c'
	fi

	local math_with='--with-math=gmp'
	if use mpir; then
		math_with='--with-math=mpir'
	fi

	local curses_with='--with-curses=no'
	if use ncurses; then
		curses_with='--with-curses=ncursesw'
	fi

	econf \
		$(use_enable code-coverage) \
		$(use_enable nls) \
		$(use_with berkdb db) \
		$(use_with xml xml2) \
		${json_with} \
		${math_with} \
		${curses_with}
}

src_install() {
	default
	rm -f "${ED}/usr/$(get_libdir)"/*.la || die
}
