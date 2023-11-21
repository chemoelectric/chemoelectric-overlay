# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Twitter API for Chicken Scheme"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc4:=
	dev-chicken/oauth:=
	dev-chicken/uri-common:=
	dev-chicken/rest-bind:=
"
DEPEND="${RDEPEND}"
