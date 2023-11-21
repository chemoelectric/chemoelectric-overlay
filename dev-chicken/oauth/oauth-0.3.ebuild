# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="OAuth 1.0, 1.0a, RFC 5849"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/uri-common:=
	dev-chicken/intarweb:=
	dev-chicken/http-client:=
	dev-chicken/hmac:=
	dev-chicken/sha1:=
	dev-chicken/base64:=
"
DEPEND="${RDEPEND}"
