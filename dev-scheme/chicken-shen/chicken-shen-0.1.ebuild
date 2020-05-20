# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Port of the Shen language for Chicken Scheme"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-scheme/chicken-args:=
	dev-scheme/chicken-srfi1:=
	dev-scheme/chicken-srfi13:=
	dev-scheme/chicken-srfi69:=
"
DEPEND="${RDEPEND}"
