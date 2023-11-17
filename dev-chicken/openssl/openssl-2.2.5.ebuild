# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings to the OpenSSL SSL/TLS library"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/openssl:=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi18:=
	dev-chicken/address-info:=
"
DEPEND="${RDEPEND}"
