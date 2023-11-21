# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Bindings to the ISAAC CSPRNG"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/module-declarations:=
"
