# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Reads & decodes HTTP multipart/form-data requests"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/intarweb:=
	dev-chicken/comparse:=
	dev-chicken/records:=
"
DEPEND="${RDEPEND}"
