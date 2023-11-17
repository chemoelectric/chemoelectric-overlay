# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Geometric algebra viewer"
HOMEPAGE="http://www.geometricalgebra.net"
SRC_URI="http://www.geometricalgebra.net/downloads/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=x11-libs/fltk-1.3.8:1
	>=dev-java/antlr-2.7.7-r9:0
	>=dev-cpp/antlr-cpp-2.7.7-r2:2
	media-libs/libpng:*
	sys-libs/zlib:*
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eapply "${FILESDIR}/${P}.configure.patch"
	eautoreconf
}

src_configure() {
	econf \
		CFLAGS="${CFLAGS} $(fltk-config --cflags)" \
		CXXFLAGS="${CXXFLAGS} $(fltk-config --cxxflags)" \
		LDFLAGS="${LDFLAGS} $(fltk-config --ldflags) -lantlr"
}
