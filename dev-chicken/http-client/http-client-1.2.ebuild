# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="High-level HTTP client library"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/intarweb:=
	dev-chicken/uri-common:=
	dev-chicken/simple-md5:=
	dev-chicken/sendfile:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
