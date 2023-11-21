# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Xlib bindings"

LICENSE="FIXME"	# The license is given as ‘unknown’. THIS IS NOT GOOD.
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/matchable:=
	dev-chicken/srfi13:=
	x11-libs/libX11:=
"
DEPEND="${RDEPEND}"
