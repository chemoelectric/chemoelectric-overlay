# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="SRFI-196: Range Objects"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi133:=
	dev-chicken/typed-records:=
	dev-chicken/utf8:=
"
DEPEND="${RDEPEND}"
