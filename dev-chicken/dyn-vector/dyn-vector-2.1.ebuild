# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Dynamic (dense) vectors based on SRFI-43"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/vector-lib:=
"
DEPEND="${RDEPEND}"
