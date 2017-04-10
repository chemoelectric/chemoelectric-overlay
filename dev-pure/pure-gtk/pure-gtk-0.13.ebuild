# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit pure-lang

DESCRIPTION="GTK+ module for Pure"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-lang/pure
	dev-libs/atk
	x11-libs/cairo
	dev-libs/glib
	x11-libs/gtk+:2
	x11-libs/pango
"
RDEPEND="${DEPEND}"
