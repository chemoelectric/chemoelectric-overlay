# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	dev-chicken/latch:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi14:=
	dev-chicken/srfi69:=
	dev-chicken/sxml-transforms:=
"
DEPEND="${RDEPEND}"
