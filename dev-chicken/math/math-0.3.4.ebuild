# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Chicken port of Racket's math library"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/r6rs-bytevectors:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi133:=
	dev-chicken/srfi42:=
"
DEPEND="${RDEPEND}"
