# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit pure-lang

DESCRIPTION="gnuplot interface for Pure"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/pure-0.47"
RDEPEND="${DEPEND} sci-visualization/gnuplot"

src_install() {
	pure-lang_src_install
	docinto examples
	dodoc gplot_test.pure
}
