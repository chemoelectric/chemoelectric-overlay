# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="EDN data reader/writer"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/r7rs:=
	dev-chicken/srfi69:=
	dev-chicken/srfi1:=
	dev-chicken/chalk:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	${RDEPEND}
	>=dev-chicken/chalk-0.3.5-r1:=
"
