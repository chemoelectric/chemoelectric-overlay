# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Computes 256-, 385- and 512-bit SHA2 checksums"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/message-digest-primitive-4.1.0:=
"
DEPEND="${RDEPEND}"