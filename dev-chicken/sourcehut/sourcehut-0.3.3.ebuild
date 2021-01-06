# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bindings and CLI for the sr.ht REST API"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/http-client:=
	dev-chicken/intarweb:=
	dev-chicken/medea:=
	dev-chicken/openssl:=
	dev-chicken/optimism:=
	dev-chicken/simple-exceptions:=
	dev-chicken/srfi1:=
	dev-chicken/srfi133:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/begin-syntax:=
	dev-chicken/module-declarations:=
"
