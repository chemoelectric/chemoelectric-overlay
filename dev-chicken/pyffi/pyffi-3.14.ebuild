# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12} )

inherit chicken-egg
inherit python-single-r1

DESCRIPTION="An interface to the Python programming language"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi69:=
	dev-chicken/bind:=
	dev-chicken/utf8:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/compile-file:=
	dev-chicken/pkg-config:=
	dev-chicken/srfi13:=
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

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
