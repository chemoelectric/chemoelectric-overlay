# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

HOMEPAGE="http://purelang.bitbucket.org/"
SRC_URI="https://bitbucket.org/purelang/pure-lang/downloads/${P}.tar.gz"
case "${PV}" in
	9999*)
		SRC_URI=""
		EHG_REPO_URI="https://bitbucket.org/purelang/pure-lang"
		EHG_PROJECT="pure-lang"
		inherit mercurial
		;;
esac

EXPORT_FUNCTIONS src_unpack src_compile src_install

# The Pure Mercurial repo contains everything except docs, so our
# working directory is actually in some subdirectory. I imagine this
# arrangement is historical; Pure used to be on Google Code, which,
# unlike Bitbucket, encouraged people to stick everything in one
# gigantic Mercurial repo (an arrangement more reminiscent of Bazaar).
[[ "${PV}" == 9999* ]] && S="${WORKDIR}/${PV}/${PN}"

pure-lang_src_unpack() {
	case "${PV}" in
		9999*)
			mercurial_fetch "${EHG_REPO_URI}" "pure-lang" "${WORKDIR}/${PV}"
			;;
		*)
			default
			;;
	esac
}

pure-lang_src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}" libdir="${EPREFIX}/usr/$(get_libdir)" ${1+"$@"}
}

any_exist() {
	/bin/ls ${1+"$@"} 1>/dev/null 2>/dev/null
}

pure-lang_src_install() {
	emake install CC="$(tc-getCC)" CXX="$(tc-getCXX)" libdir="${EPREFIX}/usr/$(get_libdir)" DESTDIR="${D}" ${1+"$@"}
	any_exist README* && dodoc README*
	any_exist *.html && dodoc *.html
	test -d examples && dodoc -r examples
}
