# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="PS/Tk: Portable Scheme interface to Tk"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

COMMON_DEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
	>=dev-lang/tcl-8.6
	dev-lang/tk
"
