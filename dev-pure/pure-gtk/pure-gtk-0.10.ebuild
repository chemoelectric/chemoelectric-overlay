# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="GTK+ module for Pure"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    >=dev-lang/pure-0.47
    >=dev-libs/atk-1.32.0-r1
    >=x11-libs/cairo-1.10.2-r1
    >=dev-libs/glib-2.28.8:2
    >=x11-libs/gtk+-2.24.6:2
    >=x11-libs/pango-1.28.4
"
RDEPEND="${DEPEND}"
