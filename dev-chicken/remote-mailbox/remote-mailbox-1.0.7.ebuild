# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Remote Mailbox"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/tcp-server:=
	dev-chicken/s11n:=
	dev-chicken/mailbox:=
	dev-chicken/srfi18:=
	>=dev-chicken/synch-3.3.5:=
	dev-chicken/miscmacros:=
	dev-chicken/moremacros:=
	dev-chicken/llrb-tree:=
	dev-chicken/condition-utils:=
	>=dev-chicken/check-errors-3.6.0:=
"
DEPEND="${RDEPEND}"
