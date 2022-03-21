# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="OSF DCE 1.1 UUID"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	sys-apps/util-linux:=
	>=dev-scheme/chicken-5.3.0:=
"
DEPEND="${RDEPEND}"
