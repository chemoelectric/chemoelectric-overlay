# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

DESCRIPTION="Common Lisp library for parsing any number string"
HOMEPAGE="http://www.cliki.net/parse-number"
SRC_URI="
	https://github.com/sharplispers/parse-number/archive/v${PV}.tar.gz -> ${PF}.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}"

src_install() {
	common-lisp-install-sources -t all *.lisp version.sexp
	common-lisp-install-asdf
}
