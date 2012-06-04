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
    >=dev-lang/pure-0.55
    >=dev-libs/atk-2.2.0
    >=x11-libs/cairo-1.10.2-r2
    >=dev-libs/glib-2.30.3:2
    >=x11-libs/gtk+-2.24.10-r1:2
    >=x11-libs/pango-1.29.4
"
RDEPEND="${DEPEND}"
