# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Tool to generate static pages out of awful applications"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/awful:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
