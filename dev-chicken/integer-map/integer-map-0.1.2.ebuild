# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Integer mappings"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi128:=
	dev-chicken/srfi143:=
	dev-chicken/srfi145:=
	dev-chicken/srfi189:=
	dev-chicken/matchable:=
"
DEPEND="${RDEPEND}"
