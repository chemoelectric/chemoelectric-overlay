# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Lab supplies for CHICKEN development"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/begin-syntax-0.1.0:=
	>=dev-chicken/debugger-protocol-0.4:=
	>=dev-chicken/schematic-0.3.1:=
	>=dev-chicken/srfi1-0.2:=
	>=dev-chicken/srfi13-0.2:=
	>=dev-chicken/srfi14-0.2:=
	>=dev-chicken/srfi69-0.3:=
	>=dev-chicken/vector-lib-2.0:=
	>=dev-chicken/with-current-directory-1.0.0:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/module-declarations:=
"
