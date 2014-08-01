# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# FIXME: This is a bad, unexamined ebuild. It ought to have multiple
# Python compatibilities and select the best Python.
#

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="Transform DocBook using TeX macros"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://dblatex.sourceforge.net/"

KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"
LICENSE="GPL-2+"
DEPEND="|| ( ( app-text/texlive
			   dev-texlive/texlive-latexextra
			   dev-texlive/texlive-pictures
			   dev-texlive/texlive-mathextra
			   dev-texlive/texlive-xetex
			 )
			 >=app-text/texlive-3
		   )
		 !<app-text/tex4ht-20090611_p1038-r1"

src_prepare() {
	epatch "${FILESDIR}/${P}.patch"
}

src_install() {
	distutils-r1_src_install
	dodir "/usr/share/doc/${PF}"
	mv "${D}usr/share/doc/${PN}"/* "${D}usr/share/doc/${PF}" || die "failed moving docdir contents"
	rmdir "${D}usr/share/doc/${PN}" || die "failed removing ${D}usr/share/doc/${PN}"
}
