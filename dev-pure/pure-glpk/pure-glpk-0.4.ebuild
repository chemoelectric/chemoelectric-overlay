# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pure-lang

DESCRIPTION="GLPK interface for Pure"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-lang/pure-0.57
	>=sci-mathematics/glpk-4.45[mysql,odbc]
	>=dev-db/libiodbc-3.52.7
"
RDEPEND="${DEPEND}"

src_compile() {
	pure-lang_src_compile ODBCLIB=-liodbc
}
