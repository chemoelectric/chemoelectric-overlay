# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings to taglib"

LICENSE="LGPL-2.1"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=media-libs/taglib-1.11.1_p20190920-r1:=
	>=dev-scheme/chicken-5.2.0:=
"
DEPEND="${RDEPEND}"
