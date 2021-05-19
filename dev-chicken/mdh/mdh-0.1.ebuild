# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="interface to the MDH database"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libpcre:=
	>=dev-scheme/chicken-5.2.0:=
"
DEPEND="${RDEPEND}"
