# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings to the OpenSSL SSL/TLS library"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi13:=
	dev-chicken/srfi18:=
	dev-chicken/address-info:=
	>=dev-libs/openssl-1.0.2:=
"
DEPEND="${RDEPEND}"
