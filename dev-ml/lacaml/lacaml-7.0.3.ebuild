# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit oasis

DESCRIPTION="BLAS/LAPACK-interface for OCaml"
HOMEPAGE="https://bitbucket.org/mmottl/${PN}"
SRC_URI="${HOMEPAGE}/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-ml/findlib-1.3.3-r1
	>=dev-lang/ocaml-4.00.1
	>=virtual/lapack-3.3
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	local cflags libs

	cflags=`pkg-config --cflags lapack blas | sed -e 's/\([^ ]\)  *\([^ ]\)/\1"; "\2/g' | sed -e 's/  *$//g'`
	libs=`pkg-config --libs lapack blas | sed -e 's/\([^ ]\)  *\([^ ]\)/\1"; "\2/g' | sed -e 's/  *$//g'`

	cat > setup.conf <<EOF
let ccopt = ["${cflags}"]
let cclib = ["${libs}"]
EOF
}
