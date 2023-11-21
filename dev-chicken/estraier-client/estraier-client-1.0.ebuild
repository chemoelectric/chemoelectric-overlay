# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A pure Scheme Hyper Estraier client library"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/http-client:=
	dev-chicken/uri-common:=
	dev-chicken/intarweb:=
"
DEPEND="${RDEPEND}"
