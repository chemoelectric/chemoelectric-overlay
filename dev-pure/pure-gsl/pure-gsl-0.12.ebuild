# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit pure-lang

DESCRIPTION="GSL interface module for Pure"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-lang/pure
	sci-libs/gsl
"
RDEPEND="${DEPEND}"
