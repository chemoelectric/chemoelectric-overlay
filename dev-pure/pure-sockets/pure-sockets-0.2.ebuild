# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="BSD sockets interface for Pure"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=sys-devel/clang-2.9"
RDEPEND="${DEPEND} >=dev-lang/pure-0.47"

src_compile() {
	pure-lang_src_compile CC=clang
}
