# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Update installed eggs"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/fmt:=
	dev-chicken/sxpath:=
	dev-chicken/http-client:=
	dev-chicken/uri-common:=
	dev-chicken/optimism:=
	dev-chicken/ssax:=
"
DEPEND="${RDEPEND}"
