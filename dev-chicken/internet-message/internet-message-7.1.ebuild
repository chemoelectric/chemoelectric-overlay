# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Parser combinators for Internet Message Format (RFC 5322)"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/yasos:=
	dev-chicken/utf8:=
	dev-chicken/abnf:=
"
DEPEND="${RDEPEND}"
