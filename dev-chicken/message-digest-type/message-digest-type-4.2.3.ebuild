# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Message Digest Type"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/check-errors:=
	dev-chicken/blob-utils:=
	dev-chicken/string-utils:=
	>=dev-chicken/message-digest-primitive-4.3.2:=
"
DEPEND="${RDEPEND}"
