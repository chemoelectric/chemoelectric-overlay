# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="An XPath implementation written in Common Lisp."
HOMEPAGE="https://www.cliki.net/plexippus-xpath"
SRC_URI="http://common-lisp.net/project/${PN}/download/${PN}-${MY_PV}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-lisp/cxml-20081130
		dev-lisp/parse-number
		>=dev-lisp/cl-ppcre-2.0.0
		>=dev-lisp/cl-yacc-0.2"

S="${WORKDIR}"/${PN}-${MY_PV}

CLSYSTEMS="xpath"

src_prepare() {
	default
	find "${S}"/doc -type f -not \( -name '*.html' -or -name '*.css' -or -name '*.gif' \) -delete
}

src_install() {
	common-lisp-install-sources *.lisp
	common-lisp-install-asdf
	if use doc; then
		cp -R doc "${T}/html"
		dodoc -r "${T}"/html
	fi
}
