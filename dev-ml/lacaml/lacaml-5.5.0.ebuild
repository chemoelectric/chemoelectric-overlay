# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils findlib

DESCRIPTION="BLAS/LAPACK-interface for OCaml"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://hg.ocaml.info/release/${PN}/archive/release-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    >=dev-lang/ocaml-3.12.0
    >=virtual/lapack-3.1
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-release-${PV}"

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
    findlib_src_install
}
