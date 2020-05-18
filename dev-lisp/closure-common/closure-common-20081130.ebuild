# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="Helper library for Closure and Closure XML implementing runes."
HOMEPAGE="https://www.cliki.net/closure-common"
SRC_URI="https://common-lisp.net/project/cxml/download/${PN}-${MY_PV}.tgz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lisp/trivial-gray-streams"

S="${WORKDIR}"/${PN}-${MY_PV}
