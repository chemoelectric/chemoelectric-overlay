# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="SRFI 209: Enums and enum sets"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi69:=
	dev-chicken/srfi113:=
	dev-chicken/srfi128:=
	dev-chicken/srfi178:=
"
DEPEND="${RDEPEND}"
