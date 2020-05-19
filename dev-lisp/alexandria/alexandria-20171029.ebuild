# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

DESCRIPTION="A collection of portable utilities for Common Lisp"
HOMEPAGE="https://common-lisp.net/project/alexandria/"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}.tar.bz2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

LICENSE="public-domain"
SLOT="0"
IUSE="doc"

DEPEND="doc? ( sys-apps/texinfo )"
RDEPEND=""

src_prepare() {
	eapply "${FILESDIR}/${PN}-fix-docstrings.patch"
	eapply_user
}

src_compile() {
	if use doc; then
		emake -C doc
	fi
}

src_install() {
	common-lisp-install-sources -t all *.lisp LICENCE
	common-lisp-install-asdf
	dodoc README AUTHORS
	if use doc; then
		doinfo doc/${PN}.info
		dodoc doc/{"${PN}.html","${PN}.pdf"}
	fi
}
