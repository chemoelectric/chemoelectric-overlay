# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pure-lang

DESCRIPTION="GTK+ module for Pure"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-lang/pure-0.57
	>=dev-libs/atk-2.6.0
	>=x11-libs/cairo-1.12.14-r4
	>=dev-libs/glib-2.32.4-r1:2
	>=x11-libs/gtk+-2.24.17:2
	>=x11-libs/pango-1.30.1
"
RDEPEND="${DEPEND}"
