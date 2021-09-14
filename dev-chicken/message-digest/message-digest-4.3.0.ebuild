# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Message Digest (omnibus)"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc2:=
	dev-chicken/message-digest-primitive:=
	>=dev-chicken/message-digest-type-4.3.0:=
	>=dev-chicken/message-digest-utils-4.3.0:=
"
DEPEND="${RDEPEND}"
