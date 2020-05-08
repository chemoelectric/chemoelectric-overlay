# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial autotools

DESCRIPTION="Bitstring Maps for ATS2"
HOMEPAGE="https://ats2libraries.sourceforge.io"
EHG_REPO_URI="http://hg.code.sf.net/p/ats2libraries/${PN}"
LICENSE="GPL-3+"

SLOT="0"
KEYWORDS=""
IUSE="static-libs"

DEPEND2="
	dev-ats2/mats2-integers:=
	dev-ats2/dsats2-modules:=
	dev-ats2/dsats2-lazy_lists:=
"
DEPEND="
	>=dev-lang/ats2-0.3.11
	sys-devel/m4:*
	${DEPEND2}
"
RDEPEND="
	${DEPEND2}
"

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
