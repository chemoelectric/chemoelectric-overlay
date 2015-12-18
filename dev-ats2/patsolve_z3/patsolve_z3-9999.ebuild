# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-r3

DESCRIPTION="Use Z3 Prover as an external constraint solver for ATS2/Postiats"
HOMEPAGE="https://github.com/githwxi/ATS-Postiats-contrib/tree/master/projects/MEDIUM/ATS-extsolve-z3"
EGIT_REPO_URI="https://github.com/githwxi/ATS-Postiats-contrib.git"

# FIXME: The licensing is unclear. One repo has an LGPL-3 COPYING
# file, another has an MIT LICENSE file, and tarballs may have no
# notice at all.
LICENSE="LGPL-3 MIT"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-lang/ats2:*
	dev-libs/json-c
"
RDEPEND="
	${DEPEND}
	sci-mathematics/z3
"

src_configure() {
	:
}

src_compile() {
	emake -C projects/MEDIUM/ATS-extsolve DATS_C
	emake -j1 -C projects/MEDIUM/ATS-extsolve-z3 build PATSHOMERELOC="${S}" || die
}

src_install() {
	dobin projects/MEDIUM/ATS-extsolve-z3/patsolve_z3
}
