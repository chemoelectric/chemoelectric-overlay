# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bloom Filter"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/iset:=
	>=dev-chicken/message-digest-primitive-4.3.2:=
	>=dev-chicken/message-digest-type-4.2.3:=
	>=dev-chicken/message-digest-utils-4.2.4:=
	>=dev-chicken/check-errors-3.5.0:=
"
DEPEND="${RDEPEND}"
