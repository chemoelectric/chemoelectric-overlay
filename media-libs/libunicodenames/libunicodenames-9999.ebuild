# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EHG_REPO_URI="https://chemoelectric@bitbucket.org/sortsmill/${PN}"

inherit eutils mercurial autotools

DESCRIPTION="a library for retrieving Unicode annotation data"
HOMEPAGE="https://bitbucket.org/sortsmill/libunicodenames"
LICENSE="LGPL-3+"

SLOT="0"
KEYWORDS=""
IUSE="doc static-libs"

RDEPEND=""
DEPEND="
    ${RDEPEND}
    >=dev-libs/gnulib-9999
    dev-util/pkgconfig
    doc? ( sys-apps/texinfo )
"

src_prepare() {
	gnulib-tool --update
	eautoreconf
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${P}" \
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
