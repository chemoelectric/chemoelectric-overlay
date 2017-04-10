# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit pure-lang

DESCRIPTION="POSIX bindings for Pure"
SRC_URI="http://pure-lang-extras.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/pure-0.47"
DEPEND="${RDEPEND} >=dev-pure/pure-doc-0.6"

src_install() {
	pure-lang_src_install
	dodoc doc/pure-posix.html
}
