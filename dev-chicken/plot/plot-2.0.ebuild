# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="An interface to libplot from GNU plotutils"

LICENSE="GPL-3"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=media-libs/plotutils-2.6-r2:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/datatype:=
	dev-chicken/matchable:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/compile-file:=
"
