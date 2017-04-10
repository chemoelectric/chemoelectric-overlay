# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit pure-lang

DESCRIPTION="Multiprecision floats for Pure, using mpfr"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-lang/pure
	dev-libs/mpfr
	dev-libs/gmp
"
RDEPEND="${DEPEND}"
