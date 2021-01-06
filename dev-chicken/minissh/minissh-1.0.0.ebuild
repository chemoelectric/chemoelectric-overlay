# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="An SSH-2 server and client implementation"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/tweetnacl:=
	dev-chicken/matchable:=
	dev-chicken/gochan:=
	dev-chicken/base64:=
	dev-chicken/queues:=
	dev-chicken/srfi13:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
	dev-chicken/message-digest-utils:=
	dev-chicken/sha2:=
"
DEPEND="${RDEPEND}"
