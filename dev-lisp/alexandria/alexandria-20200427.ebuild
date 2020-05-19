# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

DESCRIPTION="A collection of portable utilities for Common Lisp"
HOMEPAGE="https://common-lisp.net/project/alexandria/"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}-git.tgz"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

LICENSE="public-domain"
SLOT="0"
IUSE="doc"

DEPEND="doc? ( sys-apps/texinfo )"
RDEPEND=""

S="${WORKDIR}/${P}-git"

src_compile() {
	if use doc; then
		emake -C doc
	fi
}

src_install() {
	common-lisp-install-sources -t all alexandria-{1,2} LICENCE
	common-lisp-install-asdf
	dodoc README AUTHORS
	if use doc; then
		doinfo doc/${PN}.info
		dodoc doc/{"${PN}.html","${PN}.pdf"}
	fi
}
