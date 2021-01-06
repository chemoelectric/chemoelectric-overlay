# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Bloom Filter"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/iset-2.0:=
	>=dev-chicken/message-digest-primitive-4.1.1:=
	>=dev-chicken/message-digest-type-4.0.2:=
	>=dev-chicken/message-digest-utils-4.1.1:=
	>=dev-chicken/check-errors-3.1.0:=
"
DEPEND="${RDEPEND}"
