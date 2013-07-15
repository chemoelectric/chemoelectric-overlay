# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="a library for retrieving Unicode annotation data"
HOMEPAGE="https://bitbucket.org/sortsmill/libunicodenames"
SRC_URI="${HOMEPAGE}/downloads/${P}.tar.xz"
LICENSE="LGPL-3"

SLOT="0"
KEYWORDS="~amd64"
IUSE="cxx python doc static-libs"
REQUIRED_USE="python? ( cxx )"

DEPEND="
    dev-util/pkgconfig
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
		$(use_enable cxx c++) \
		$(use_enable python) \
		$(use_enable static-libs static)
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README
	if use doc; then
		for format in html pdf ps dvi; do
			emake install-${format} DESTDIR="${D}" \
				MAKEINFOFLAGS="--no-split"
		done
	fi
}

src_test() {
	# FIXME: We do not have the Python tests working in an ebuild, yet.
	emake check TESTSUITEFLAGS='-k !python'
}
