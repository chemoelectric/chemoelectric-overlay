# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Fetch and install CHICKEN versions"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/http-client:=
	dev-chicken/memory-mapped-files:=
	dev-chicken/openssl:=
	dev-chicken/posix-groups:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-chicken/begin-syntax-0.2.1:=
	>=dev-chicken/matchable-1.1:=
	>=dev-chicken/module-declarations-0.2.1:=
"
