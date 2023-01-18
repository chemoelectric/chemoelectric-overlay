# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Lab supplies for CHICKEN development"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/begin-syntax:=
	dev-chicken/debugger-protocol:=
	dev-chicken/schematic:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi14:=
	dev-chicken/srfi69:=
	dev-chicken/vector-lib:=
	dev-chicken/with-current-directory:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/module-declarations:=
"
