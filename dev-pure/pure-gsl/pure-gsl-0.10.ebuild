# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="GSL interface module for Pure"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-lang/pure-0.47
	>=sci-libs/gsl-1.15
"
RDEPEND="${DEPEND}"
