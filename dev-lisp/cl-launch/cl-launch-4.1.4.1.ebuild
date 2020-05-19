# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

DESCRIPTION="Utility to make your Lisp software easily invokable from the shell command-line"
HOMEPAGE="https://www.cliki.net/cl-launch"
SRC_URI="https://common-lisp.net/project/xcvb/${PN}/${P}.tar.gz"
LICENSE="LLGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_install() {
	mkdir -p "${D}/usr/bin" || die
	emake PREFIX="${D}/usr" install
}
