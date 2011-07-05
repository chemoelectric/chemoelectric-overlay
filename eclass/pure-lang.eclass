# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

HOMEPAGE="http://pure-lang.googlecode.com/"
SRC_URI="http://pure-lang.googlecode.com/files/${P}.tar.gz"

pure-lang_src_compile() {
	emake libdir="${EPREFIX}/usr/$(get_libdir)"
}

pure-lang_src_install() {
	emake install libdir="${EPREFIX}/usr/$(get_libdir)" DESTDIR="${D}"
}
