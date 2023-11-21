# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="SRFI 178: Bitvector library"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi151:=
	dev-chicken/srfi160:=
	dev-chicken/srfi141:=
"
DEPEND="${RDEPEND}"
