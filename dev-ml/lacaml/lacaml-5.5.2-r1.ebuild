# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils findlib

DESCRIPTION="BLAS/LAPACK-interface for OCaml"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://hg.ocaml.info/release/${PN}/archive/release-${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/pkgconfig"
RDEPEND="
	${DEPEND}
	>=dev-lang/ocaml-3.12.1
	>=virtual/lapack-3.3
"

S="${WORKDIR}/${PN}-release-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-r1-libraries.patch"
}

src_compile() {
	emake -j1
}

src_install() {
	findlib_src_install
}
