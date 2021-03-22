# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial
inherit autotools

DESCRIPTION="Gaigen 2.5: Geometric Algebra Implementation Generator"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/g25/"
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/g25"
LICENSE="GPL-3+ LGPL-2.1+ BSD"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-lang/mono-6.10.0.104:=
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	>=app-text/texlive-core-2020-r12:*
	>=dev-texlive/texlive-basic-2020-r1:*
	>=dev-texlive/texlive-latex-2020:*
	>=dev-texlive/texlive-latexextra-2020-r2:*
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf CSC=/usr/bin/csc \
		  MONO=/usr/bin/mono \
		  MCS=/usr/bin/mcs
}
