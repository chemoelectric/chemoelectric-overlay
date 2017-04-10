# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs pure-lang

DESCRIPTION="Computer Algebra with Pure: A Reduce Interface"
SRC_URI+=" https://bitbucket.org/purelang/pure-lang/downloads/reduce-algebra-csl-r2204.tar.bz2"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/pure"
DEPEND="${RDEPEND}"

src_prepare () {
	mv "${WORKDIR}/reduce-algebra" "${S}" || die "mv failed"
}

src_compile() {
	CFLAGS+=" -I. `$(tc-getPKG_CONFIG) pure --cflags` -DPAGE_BITS=19 -DHAVE_CONFIG_H=1 -DEMBEDDED=1 -w"

	# Upstream cannot handle parallel build.
	emake -j1 CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}" libdir="${EPREFIX}/usr/$(get_libdir)"
}
