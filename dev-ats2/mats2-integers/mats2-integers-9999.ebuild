# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial autotools

DESCRIPTION="Integers for ATS2"
HOMEPAGE="https://ats2libraries.sourceforge.io"
EHG_REPO_URI="http://hg.code.sf.net/p/ats2libraries/${PN}"
LICENSE="GPL-3+"

SLOT="0"
KEYWORDS=""
IUSE="cvc4 int128 +proof-implementations static-libs"

DEPEND="
	dev-lang/ats2:=[gmp]
	dev-ats2/ats2-patstrans
	cvc4? ( dev-lang/ats2:=[smt2]
			sci-mathematics/cvc4 )
"
RDEPEND=""

QA_AM_MAINTAINER_MODE=".*--language=autotest.*"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable cvc4) \
		$(use_enable int128) \
		$(use_enable proof-implementations) \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
