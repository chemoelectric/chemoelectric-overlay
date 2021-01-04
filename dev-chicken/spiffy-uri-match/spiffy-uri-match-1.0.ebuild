# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="uri-match integration for spiffy"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/uri-match:=
	dev-chicken/spiffy:=
	dev-chicken/uri-common:=
	dev-chicken/intarweb:=
"
DEPEND="${RDEPEND}"
