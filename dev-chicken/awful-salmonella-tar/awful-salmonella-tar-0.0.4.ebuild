# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Serve salmonella report files out of tar archives"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/awful:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
"
DEPEND="${RDEPEND}"
