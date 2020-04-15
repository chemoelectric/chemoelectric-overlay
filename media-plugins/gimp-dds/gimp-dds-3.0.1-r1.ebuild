# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="DirectDraw Surface (DDS) format plugin for Gimp 2"
HOMEPAGE="https://code.google.com/archive/p/gimp-dds/"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-gfx/gimp-2.8:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	default
	sed -e 's:CFLAGS=.*\$(:CFLAGS+=\$(:' \
		-e 's:LDFLAGS=:LDFLAGS+=:' \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" VERBOSE=1
}

src_install() {
	exeinto "$(pkg-config --variable=gimplibdir gimp-2.0)/plug-ins"
	doexe dds

	# No need to install the gimp-dds.odt or the images, as they have the same
	# content as the gimp-dds.pdf
	dodoc README TODO doc/gimp-dds.pdf
}
