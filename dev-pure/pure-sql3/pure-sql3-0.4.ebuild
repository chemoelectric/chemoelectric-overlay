# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="SQLite3 interface for Pure"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-lang/pure-0.47
	>=dev-db/sqlite-3.7.7.1:3
	>=dev-libs/gmp-5.0.2
"
RDEPEND="${DEPEND}"
