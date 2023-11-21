# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Statistics library"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi25:=
	dev-chicken/srfi69:=
	dev-chicken/vector-lib:=
	dev-chicken/random-mtzig:=
	dev-chicken/yasos:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/compile-file:=
	dev-chicken/srfi13:=
"
