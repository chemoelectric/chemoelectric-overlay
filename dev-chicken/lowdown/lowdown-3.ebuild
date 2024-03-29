# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A pure Chicken Markdown parser"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/char-set-literals:=
	dev-chicken/clojurian:=
	>=dev-chicken/comparse-3:=
	dev-chicken/fancypants:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi14:=
	dev-chicken/srfi69:=
	dev-chicken/sxml-transforms:=
"
DEPEND="${RDEPEND}"
