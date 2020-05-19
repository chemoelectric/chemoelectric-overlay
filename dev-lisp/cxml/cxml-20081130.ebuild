# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="An XML parser written in Common Lisp"
HOMEPAGE="https://common-lisp.net/project/cxml/"
SRC_URI="https://common-lisp.net/project/${PN}/download/${PN}-${MY_PV}.tgz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="!dev-lisp/cl-${PN}
		>=dev-lisp/closure-common-${PV}
		dev-lisp/puri
		dev-lisp/trivial-gray-streams"

CLSYSTEMS="${PN} ${PN}-contrib"

S="${WORKDIR}"/${PN}-${MY_PV}

src_prepare() {
	default
	rm -f "${S}"/GNUmakefile
	cp "${FILESDIR}"/${PN}-contrib.asd "${S}" || die
}

src_install() {
	common-lisp-install-sources *.dtd
	common-lisp-install-sources {contrib,dom,klacks,test,xml,xml/sax-tests}/*.lisp
	common-lisp-install-asdf

	dodoc README OLDNEWS TIMES

	if use doc; then
		cp -R doc "${T}/html"
		find "${T}"/html -name GNUmakefile -delete || die
		find "${T}"/html -name '*.xml' -delete || die
		find "${T}"/html -name '*.xsl' -delete || die
		dodoc -r "${T}"/html
	fi
}
