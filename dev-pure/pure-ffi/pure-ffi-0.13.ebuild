# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit pure-lang

DESCRIPTION="libffi interface for Pure"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-lang/pure-0.51
	virtual/libffi
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_compile() {
	emake CPPFLAGS=`pkg-config --cflags libffi`
}
