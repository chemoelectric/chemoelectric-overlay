# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A more convenient HTTP library"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi14:=
	dev-chicken/defstruct:=
	dev-chicken/uri-common:=
	dev-chicken/base64:=
"
DEPEND="${RDEPEND}"
