# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools multilib

DESCRIPTION="An open source C library for image processing and analysis"
HOMEPAGE="http://www.leptonica.com/"
SRC_URI="http://www.leptonica.com/source/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=sys-libs/zlib-1.2.5-r2
	virtual/jpeg
	>=media-libs/giflib-4.1.6-r1
	>=media-libs/tiff-4.0.0_beta7
	>=media-libs/libpng-1.4.7
	>=media-libs/libwebp-0.1.2
"
RDEPEND="${DEPEND}"

DOCS=( README version-notes )

src_prepare() {
	# unhtmlize docs (they're just one big <pre/>s)
	local docf
	for _docf in ${DOCS[@]}; do
		awk '/<\/pre>/{s--} {if (s) print $0} /<pre>/{s++}' \
			${_docf}.html > ${_docf} || die 'awk failed.'
	done
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed.'
	dodoc ${DOCS[@]} || die 'dodoc failed.'

	# remove .la file, it was needed only to build shared lib
	rm "${D}"/usr/$(get_libdir)/liblept.la || die 'rm failed.'
}
