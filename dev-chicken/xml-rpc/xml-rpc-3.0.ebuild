# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="XML-RPC client/server"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/base64:=
	dev-chicken/http-client:=
	dev-chicken/intarweb:=
	dev-chicken/ssax:=
	dev-chicken/sxpath:=
	dev-chicken/srfi13:=
"
DEPEND="${RDEPEND}"
