# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A sorted dictionary data structure based on red-black trees"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/datatype:=
	dev-chicken/matchable:=
	dev-chicken/yasos:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
