# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Convenience macro for inline syntax expansion"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/matchable:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-chicken/module-declarations-0.2.1:=
"
