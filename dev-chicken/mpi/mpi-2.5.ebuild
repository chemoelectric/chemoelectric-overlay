# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Message-passing Interface (MPI)"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	virtual/mpi:=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi14:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/srfi1:=
	dev-chicken/compile-file:=
"
