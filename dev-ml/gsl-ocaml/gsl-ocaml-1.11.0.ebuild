# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit oasis

DESCRIPTION="GSL-Bindings for OCaml"
HOMEPAGE="https://bitbucket.org/mmottl/${PN}"
SRC_URI="${HOMEPAGE}/downloads/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
    >=dev-ml/findlib-1.3.3-r1
    >=dev-lang/ocaml-4.00.1
    >=sci-libs/gsl-1.15
"
DEPEND="${RDEPEND}"
