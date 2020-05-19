# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

DESCRIPTION="Common Lisp package to encode and decode base64 with URI support"
HOMEPAGE="https://www.cliki.net/cl-base64"
SRC_URI="http://files.kpe.io/${PN}/${PF}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lisp/kmrcl"
