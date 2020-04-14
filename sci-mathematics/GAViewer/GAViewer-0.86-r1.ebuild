# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils autotools

DESCRIPTION="Geometric algebra viewer"
HOMEPAGE="http://www.geometricalgebra.net"
SRC_URI="http://www.geometricalgebra.net/downloads/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# FIXME: Needs C++ runtime for Antlr.
DEPEND=">=x11-libs/fltk-1.3.0:1
	    >=dev-java/antlr-2.7.7-r5:0
	    >=media-libs/libpng-1.5.6
	    >=sys-libs/zlib-1.2.5.1-r2"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	epatch "${FILESDIR}/${P}.configure.patch"
	eautoreconf
}

src_configure() {
	econf \
		CFLAGS="${CFLAGS} `fltk-config --cflags` `antlr-config --cflags`" \
		CXXFLAGS="${CXXFLAGS} `fltk-config --cxxflags` `antlr-config --cflags`" \
		LDFLAGS="${LDFLAGS} `fltk-config --ldflags`"
}
