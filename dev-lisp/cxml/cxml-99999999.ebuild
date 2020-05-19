# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
inherit common-lisp-3

DESCRIPTION="An XML parser written in Common Lisp"
HOMEPAGE="http://common-lisp.net/project/cxml/"
EGIT_REPO_URI="https://repo.or.cz/${PN}.git"

LICENSE="LLGPL-2.1"
SLOT="0"
IUSE="doc"

# For xsltproc to build the documentation.
DEPEND="doc? ( dev-libs/libxslt )"

RDEPEND="!dev-lisp/cl-${PN}
		>=dev-lisp/closure-common-${PV}
		dev-lisp/puri
		dev-lisp/trivial-gray-streams"

src_prepare() {
	default
	rm -f "${S}"/GNUmakefile
}

src_compile() {
	pushd doc > /dev/null || die
	for f in *.xml; do
		xsltproc html.xsl "${f}" > "${f/.xml/.html}"
	done
	popd > /dev/null || die
}

src_install() {
	common-lisp-install-sources -t all *.dtd
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
