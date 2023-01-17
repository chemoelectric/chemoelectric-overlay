# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Message Digest Support"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/blob-utils:=
	dev-chicken/string-utils:=
	dev-chicken/memory-mapped-files:=
	dev-chicken/message-digest-primitive:=
	>=dev-chicken/message-digest-type-4.3.0:=
	>=dev-chicken/check-errors-3.6.0:=
"
DEPEND="${RDEPEND}"
