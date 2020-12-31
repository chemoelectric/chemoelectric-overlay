# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings for zlib"

LICENSE="GPL-3"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	sys-libs/zlib:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/foreigners:=
	dev-chicken/miscmacros:=
"
DEPEND="${RDEPEND}"
