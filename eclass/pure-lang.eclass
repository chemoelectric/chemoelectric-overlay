# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

HOMEPAGE="http://pure-lang.googlecode.com/"
SRC_URI="http://pure-lang.googlecode.com/files/${P}.tar.gz"
case "${PV}" in
	9999)
		SRC_URI=""
		EHG_REPO_URI="https://pure-lang.googlecode.com/hg"
		EHG_PROJECT="pure-lang"
		inherit mercurial
		;;
esac

EXPORT_FUNCTIONS src_compile src_install

pure-lang_src_compile() {
	test x"${PV}" = x9999 && cd ${PN}
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" libdir="${EPREFIX}/usr/$(get_libdir)"
}

any_exist() {
	/bin/ls ${1+"$@"} 1>/dev/null 2>/dev/null
}

pure-lang_src_install() {
	test x"${PV}" = x9999 && cd ${PN}
	emake install CC="$(tc-getCC)" CXX="$(tc-getCXX)" libdir="${EPREFIX}/usr/$(get_libdir)" DESTDIR="${D}"
	any_exist README* && dodoc README*
	any_exist *.html && dodoc *.html
	test -d examples && dodoc -r examples
}
