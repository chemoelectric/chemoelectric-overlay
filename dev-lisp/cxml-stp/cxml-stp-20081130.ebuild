# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="A Common Lisp alternative to the W3C's DOM."
HOMEPAGE="http://www.lichteblau.com/cxml-stp/"
SRC_URI="http://www.lichteblau.com/${PN}/download/${PN}-${MY_PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="
	dev-lisp/cxml
	dev-lisp/alexandria
	dev-lisp/plexippus-xpath
"

S="${WORKDIR}"/${PN}-${MY_PV}

my_install_doc() {
	cp -R "${1}" "${T}/${2}" || die
	dodoc -r "${T}/${2}"
}

src_prepare() {
	default
	rm -f "${S}"/{tutorial,}/GNUmakefile
	rm -f "${S}"/tutorial/tutorial.{xml,xsl}
}

src_install() {
	common-lisp-install-sources *.lisp
	common-lisp-install-asdf
	dodoc DOM-COMPARISON README

	if use doc; then
		my_install_doc doc html
		my_install_doc tutorial tutorial
	fi
}
