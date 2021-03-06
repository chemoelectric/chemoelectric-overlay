# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="EDN data reader/writer"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/r7rs:=
	dev-chicken/srfi69:=
	dev-chicken/srfi1:=
	dev-chicken/hahn:=
"
DEPEND="${RDEPEND}"
