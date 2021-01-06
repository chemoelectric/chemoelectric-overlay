# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="An interface to level 1, 2 and 3 BLAS routines"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/bind:=
	virtual/cblas:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/compile-file:=
	dev-chicken/srfi13:=
	virtual/pkgconfig:*
"

src_prepare() {
	chicken-egg_src_prepare

	# Do not waste time trying to build with bad flags.
	local libs=`pkg-config --libs cblas`
	sed -e "s|(or (blas-test |(or (blas-test (\"<cblas.h>\" \"${libs} -lm\")) (blas-test |" \
		-i build.scm || die
}
