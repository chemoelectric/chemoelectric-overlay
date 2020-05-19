# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

DESCRIPTION="General Utilities for Common Lisp Programs from Kevin Rosenberg"
HOMEPAGE="https://www.cliki.net/kmrcl"
SRC_URI="http://files.kpe.io/${PN}/${PF}.tar.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}
		dev-lisp/rt"

CLSYSTEMS="${PN} ${PN}-tests"

RESTRICT="test"					# FIXME: Tests are not working.

run_test() {
	local lisp="${1}"
	if has_version "dev-lisp/${lisp}" ; then
		emake test-"${lisp}"
	fi
}

src_compile() {
	:
}

src_test() {
	for l in sbcl cmucl clisp; do
		run_test "${l}"
	done
}
