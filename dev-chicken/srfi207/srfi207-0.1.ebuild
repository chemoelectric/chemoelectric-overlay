# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="SRFI-207: String-notated bytevectors"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi145:=
	dev-chicken/srfi151:=
	dev-chicken/srfi152:=
	dev-chicken/srfi160:=
	dev-chicken/r7rs:=
"
DEPEND="${RDEPEND}"
