# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pure-lang

DESCRIPTION="Pure interface to C++ STL maps and vectors"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/pure"
DEPEND="${RDEPEND}"

src_install() {
	default
	dodoc doc/pure-stllib-cheatsheet.pdf
}
