# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit xorg-3

DESCRIPTION="X.Org xkbui library"

KEYWORDS="~amd64"
IUSE=""

RDEPEND="x11-base/xorg-proto
	x11-libs/libXt
	>=x11-libs/libxkbfile-1.0.3"
DEPEND="${RDEPEND}"
