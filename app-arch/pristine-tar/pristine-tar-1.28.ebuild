# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Regenerate pristine tarballs"
HOMEPAGE="http://packages.debian.org/search?keywords=pristine-tar"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2+"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-lang/perl
	app-arch/tar
	=dev-util/xdelta-1*
"
DEPEND="
	${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

S=${WORKDIR}/${PN}

src_prepare() {
	perl Makefile.PL					\
		TAR_PROGRAM=/bin/tar			\
		XDELTA_PROGRAM=/usr/bin/xdelta	\
		PREFIX=/usr
}
