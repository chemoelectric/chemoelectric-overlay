# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

DESCRIPTION="Flexible bivalent streams for Common Lisp"
HOMEPAGE="https://edicl.github.io/flexi-streams/"
SRC_URI="
	https://github.com/edicl/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="
	!dev-lisp/cl-${PN}
	>=dev-lisp/trivial-gray-streams-20060925
"

src_install() {
	common-lisp-install-sources *.lisp
	common-lisp-install-asdf
	dodoc docs/index.html
}
