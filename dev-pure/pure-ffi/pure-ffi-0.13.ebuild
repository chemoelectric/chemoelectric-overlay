# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="libffi interface for Pure"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    >=dev-lang/pure-0.51
    virtual/libffi
    dev-util/pkgconfig
"
RDEPEND="${DEPEND}"

src_compile() {
	emake CPPFLAGS=`pkg-config --cflags libffi`
}
