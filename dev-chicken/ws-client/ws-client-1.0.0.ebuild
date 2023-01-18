# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="websocket client library"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=sys-libs/zlib-1.2.11:=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/foreigners:=
	dev-chicken/string-utils:=
	dev-chicken/base64:=
	dev-chicken/simple-sha1:=
	dev-chicken/uri-common:=
	dev-chicken/intarweb:=
	dev-chicken/openssl:=
"
DEPEND="${RDEPEND}"
