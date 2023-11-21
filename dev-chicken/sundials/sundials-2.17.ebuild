# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="An interface to SUNDIALS (a suite of nonlinear solvers)"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	sci-libs/sundials:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/srfi13:=
	dev-chicken/compile-file:=
"
