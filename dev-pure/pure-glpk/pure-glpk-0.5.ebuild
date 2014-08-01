# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pure-lang

DESCRIPTION="GLPK interface for Pure"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-lang/pure
	sci-mathematics/glpk[mysql,odbc]
	dev-db/libiodbc
"
RDEPEND="${DEPEND}"

src_compile() {
	pure-lang_src_compile ODBCLIB=-liodbc
}
