# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Parse, normalize, and write SVG path data"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/brev-separate:=
	dev-chicken/clojurian:=
	dev-chicken/match-generics:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi1:=
	dev-chicken/srfi69:=
	dev-chicken/strse:=
	dev-chicken/sxpath:=
	dev-chicken/tree:=
"
DEPEND="${RDEPEND}"
