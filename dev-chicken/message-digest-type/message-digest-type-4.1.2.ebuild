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
	>=dev-chicken/check-errors-3.1.0:=
	>=dev-chicken/blob-utils-2.0.0:=
	>=dev-chicken/string-utils-2.0.4:=
	>=dev-chicken/message-digest-primitive-4.1.0:=
"
DEPEND="${RDEPEND}"
