# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="An implementation of Relax NG schema validation written in Common Lisp."
HOMEPAGE="http://www.lichteblau.com/cxml-rng/"
SRC_URI="http://www.lichteblau.com/${PN}/download/${PN}-${MY_PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="
	>=dev-lisp/cxml-${PV}
	>=dev-lisp/cl-ppcre-2.0.0
	>=dev-lisp/cl-yacc-0.2
	>=dev-lisp/parse-number-1.0
	dev-lisp/cl-base64
"

S="${WORKDIR}"/${PN}-${MY_PV}

src_prepare() {
	default
	rm "${S}"/GNUmakefile
}

src_install() {
	common-lisp-install-sources *.{lisp,rng,rnc}
	common-lisp-install-asdf

	dodoc README NEWS NIST *TEST
	if use doc; then
		cp -R doc "${T}/html"
		dodoc -r "${T}"/html
	fi
}
