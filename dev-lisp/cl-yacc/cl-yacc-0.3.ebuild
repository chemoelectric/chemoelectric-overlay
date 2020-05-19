# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

DESCRIPTION="CL-YACC is a LALR(1) parser generator for Common Lisp"
HOMEPAGE="
	http://www.pps.jussieu.fr/~jch/software/cl-yacc/
	http://www.cliki.net/CL-Yacc
"
SRC_URI="http://www.pps.jussieu.fr/~jch/software/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="
	sys-apps/texinfo
	doc? ( virtual/texi2dvi )
"

src_compile() {
	makeinfo ${PN}.texi -o ${PN}.info
	if use doc; then
		VARTEXFONTS="${T}"/fonts texi2pdf ${PN}.texi -o ${PN}.pdf
	fi
}

src_install() {
	common-lisp-install-sources yacc{,-tests}.lisp
	common-lisp-install-asdf

	dodoc CHANGES README
	doinfo ${PN}.info
	use doc && dodoc ${PN}.pdf
	docinto examples && dodoc calculator.lisp
}
