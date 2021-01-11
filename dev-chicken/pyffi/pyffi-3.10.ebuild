# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#
# FIXME: As of 10 January 2021, the ebuild has been tested only with
#        python_single_target_python3_8
#
PYTHON_COMPAT=( python2_7 python3_{7,8,9} )

inherit chicken-egg
inherit python-single-r1

DESCRIPTION="An interface to the Python programming language"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi69:=
	dev-chicken/bind:=
	dev-chicken/utf8:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=virtual/pkgconfig-2:*
	dev-chicken/compile-file:=
	dev-chicken/srfi13:=
"

src_prepare() {
	python_setup
	chicken-egg_src_prepare
}

src_compile() {
	python_setup

	local python_embed_pc="${EPYTHON//python/python-}-embed"

	export PYTHON_CFLAGS=`pkg-config --cflags "${python_embed_pc}"`
	export PYTHON_LFLAGS="-L /usr/$(get_libdir)"
	export PYTHON_LIBS=`pkg-config --libs "${python_embed_pc}"`

	elog "PYTHON_CFLAGS=${PYTHON_CFLAGS}"
	elog "PYTHON_LFLAGS=${PYTHON_LFLAGS}"
	elog "PYTHON_LIBS=${PYTHON_LIBS}"

	chicken-egg_src_compile
}
