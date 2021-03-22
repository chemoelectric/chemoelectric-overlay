# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Gaigen 2.5: Geometric Algebra Implementation Generator"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/g25/"
SRC_URI="mirror://sourceforge/projects/chemoelectric/files/Crud%20Factory%20Gaigen%202.5/g25-2.5.1000.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
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

src_configure() {
	econf CSC=/usr/bin/csc \
		  MONO=/usr/bin/mono \
		  MCS=/usr/bin/mcs
}
