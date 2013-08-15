# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="Multiprecision floats for Pure, using mpfr"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-lang/pure-0.50
	>=dev-libs/mpfr-3.0.1_p4
	>=dev-libs/gmp-5.0.2
"
RDEPEND="${DEPEND}"
