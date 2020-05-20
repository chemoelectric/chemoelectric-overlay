# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Miscellaneous list oriented routines for CHICKEN Scheme"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-scheme/chicken-check-errors-3.1.0:=
	>=dev-scheme/chicken-srfi1-0.1:=
"
DEPEND="${RDEPEND}"
