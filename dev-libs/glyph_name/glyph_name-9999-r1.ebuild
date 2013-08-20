# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_{6,7},3_{1,2,3}} )

inherit distutils-r1 git-2

IUSE="python nolib"

DESCRIPTION="A library for computing Unicode sequences from glyph names"
HOMEPAGE="https://bitbucket.org/chemoelectric/glyph_name"
SRC_URI=""
EGIT_REPO_URI="https://chemoelectric@bitbucket.org/chemoelectric/glyph_name.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	python? ( dev-lang/python )
"
DEPEND="
	dev-lang/python
	!nolib? ( >=dev-util/scons-1.2.0-r1 sys-devel/m4 )
	${RDEPEND}
"

S="${WORKDIR}/${PN}"

src_compile() {
	if ! use nolib; then
		scons --include_soname || die "scons compile failed"
	fi
	if use python; then
		cp setup-no_cython.py setup.py
		distutils-r1_src_compile || die "distutils_src_compile failed"
	fi
}

src_install() {
	if ! use nolib; then
		scons --prefix="${D}/usr" --libdir="${D}/usr/$(get_libdir)" --include_soname install || \
	   		die "scons install failed"
	fi
	if use python; then
		distutils-r1_src_install || die "distutils_src_install failed"
	fi
}
