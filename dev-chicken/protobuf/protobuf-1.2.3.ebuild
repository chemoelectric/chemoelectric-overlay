# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Protocol buffer serialization"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi13:=
	dev-chicken/srfi18:=
	dev-chicken/srfi42:=
	dev-chicken/srfi69:=
	dev-chicken/srfi99:=
"
DEPEND="${RDEPEND}"
