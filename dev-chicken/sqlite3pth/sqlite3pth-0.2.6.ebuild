# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Run SQLite queries asynchronously in pthreads"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/sqlite:3=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/pthreads:=
	dev-chicken/srfi34:=
	dev-chicken/llrb-tree:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
