# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Application and extension to ease the development of web-based applications"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
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
