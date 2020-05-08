# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial autotools

DESCRIPTION="Data Structure Modules for ATS2"
HOMEPAGE="https://ats2libraries.sourceforge.io"
EHG_REPO_URI="http://hg.code.sf.net/p/ats2libraries/${PN}"
LICENSE="GPL-3+"

SLOT="0"
KEYWORDS=""
IUSE="static-libs"

DEPEND="
	dev-ats2/dsats2-lazy_lists:=
	>=dev-lang/ats2-0.3.11
"
RDEPEND=""

QA_AM_MAINTAINER_MODE=".*--language=autotest.*"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
