# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Fetch and cache extensions from various sources for Henrietta to consume"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/http-client:=
	dev-chicken/matchable:=
	dev-chicken/srfi1:=
	app-arch/gzip:*
	app-arch/bzip2:*
	app-arch/tar:*
"
DEPEND="${RDEPEND}"
