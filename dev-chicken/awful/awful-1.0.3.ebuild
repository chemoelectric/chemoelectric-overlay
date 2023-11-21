# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Application and an extension to ease the development of web-based applications"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/json:=
	dev-chicken/http-session:=
	dev-chicken/spiffy:=
	dev-chicken/spiffy-cookies:=
	dev-chicken/spiffy-request-vars:=
	dev-chicken/sxml-transforms:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
