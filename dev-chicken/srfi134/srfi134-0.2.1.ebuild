# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="SRFI 134: Immutable deques"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc4:=
	dev-chicken/srfi1:=
	dev-chicken/srfi158:=
	dev-chicken/srfi145:=
	dev-chicken/typed-records:=
"
DEPEND="${RDEPEND}"
