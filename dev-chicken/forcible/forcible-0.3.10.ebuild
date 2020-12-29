# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Thread- and exception aware, lazy-looking synchronization with timeouts"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi18:=
	>=dev-chicken/pigeon-hole-0.2.7:=
	dev-chicken/simple-timer:=
"
DEPEND="${RDEPEND}"
