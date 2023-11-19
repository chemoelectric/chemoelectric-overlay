# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Client for Advanced Message Queueing Protocol v0.9.1"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/bitstring:=
	dev-chicken/mailbox:=
	dev-chicken/srfi18:=
	dev-chicken/uri-generic:=
"
DEPEND="${RDEPEND}"
