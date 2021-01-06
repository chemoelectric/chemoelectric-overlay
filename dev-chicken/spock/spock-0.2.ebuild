# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A compiler and runtime system for R5RS Scheme on top of JavaScript"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/jsmin:=
	dev-chicken/matchable:=
	dev-chicken/make:=
"
DEPEND="${RDEPEND}"
