# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A tool to test new eggs before they are added to the official CHICKEN repository"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/henrietta-cache:=
	dev-chicken/salmonella:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
