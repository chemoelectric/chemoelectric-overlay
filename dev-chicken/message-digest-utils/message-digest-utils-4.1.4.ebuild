# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Message Digest Support"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/check-errors-3.1.0:=
	>=dev-chicken/blob-utils-2.0.0:=
	>=dev-chicken/string-utils-2.0.5:=
	>=dev-chicken/memory-mapped-files-0.2:=
	>=dev-chicken/message-digest-primitive-4.1.0:=
	>=dev-chicken/message-digest-type-4.0.1:=
"
DEPEND="${RDEPEND}"
