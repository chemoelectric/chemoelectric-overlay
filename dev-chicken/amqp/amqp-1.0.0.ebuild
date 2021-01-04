# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="AMPQ"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/bitstring:=
	dev-chicken/mailbox:=
	dev-chicken/srfi18:=
	dev-chicken/uri-generic:=
"
DEPEND="${RDEPEND}"
