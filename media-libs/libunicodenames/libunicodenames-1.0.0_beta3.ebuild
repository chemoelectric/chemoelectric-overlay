# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="a library for retrieving Unicode annotation data"
HOMEPAGE="https://github.com/chemoelectric/libunicodenames"
SRC_URI="https://github.com/downloads/chemoelectric/${PN}/${P}.tar.xz"
LICENSE="LGPL-3"

SLOT="0"
KEYWORDS="~amd64"
IUSE="cxx python doc static-libs"
REQUIRED_USE="python? ( cxx )"

DEPEND="
    python? ( dev-lang/python
              >=dev-lang/swig-2.0.4-r1 )
    doc? ( sys-apps/texinfo )
"
RDEPEND="
    python? ( dev-lang/python )
"

src_configure() {
	econf \
		--docdir="/usr/share/doc/${P}" \
		--disable-silent-rules \
		$(use_enable cxx c++) \
		$(use_enable python) \
		$(use_enable static-libs static)
}

src_install() {
	emake -j1 install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README
	if use doc; then
		for format in html pdf ps dvi; do
			emake install-${format} DESTDIR="${D}" \
				MAKEINFOFLAGS="--no-split"
		done
	fi
}
