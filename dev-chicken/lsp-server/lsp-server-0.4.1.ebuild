# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="LSP Server for CHICKEN"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/apropos:=
	dev-chicken/chicken-doc:=
	dev-chicken/json-rpc:=
	dev-chicken/nrepl:=
	dev-chicken/r7rs:=
	dev-chicken/srfi1:=
	dev-chicken/srfi130:=
	dev-chicken/srfi133:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
	dev-chicken/uri-generic:=
	dev-chicken/utf8:=
"
DEPEND="${RDEPEND}"
