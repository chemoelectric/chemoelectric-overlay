# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Chicken bindings for espeak-ng's speak_lib.h"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	app-accessibility/espeak-ng:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/utf8:=
	dev-chicken/foreigners:=
	dev-chicken/srfi18:=
"
DEPEND="${RDEPEND}"
