# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings to taglib"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=media-libs/taglib-1.12:=
	>=dev-scheme/chicken-5.3.0_rc2:=
"
DEPEND="${RDEPEND}"
