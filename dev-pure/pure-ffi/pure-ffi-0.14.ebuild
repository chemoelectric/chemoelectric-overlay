# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs pure-lang

DESCRIPTION="libffi interface for Pure"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-lang/pure
	virtual/libffi
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		CFLAGS="${CFLAGS} `$(tc-getPKG_CONFIG) --cflags libffi`" \
		libdir="${EPREFIX}/usr/$(get_libdir)"
}
