# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Transmission RPC"

LICENSE="Unlicense"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/http-client:=
	dev-chicken/intarweb:=
	dev-chicken/medea:=
	dev-chicken/r7rs:=
	dev-chicken/srfi1:=
	dev-chicken/srfi189:=
	dev-chicken/uri-common:=
"
DEPEND="${RDEPEND}"
