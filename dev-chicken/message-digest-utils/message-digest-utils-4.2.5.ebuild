# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Message Digest Support"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/check-errors:=
	dev-chicken/blob-utils:=
	dev-chicken/string-utils:=
	dev-chicken/memory-mapped-files:=
	>=dev-chicken/message-digest-primitive-4.3.2:=
	>=dev-chicken/message-digest-type-4.2.3:=
"
DEPEND="${RDEPEND}"
