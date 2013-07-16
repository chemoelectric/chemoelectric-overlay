# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

#inherit eutils

DESCRIPTION="Tool that converts source archives into Debian package source"
HOMEPAGE="http://packages.debian.org/sid/${PN}"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-3.0+-with-template-exception"

SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
    dev-lang/perl
    virtual/perl-Getopt-Long
"

S="${WORKDIR}/${PN}"

src_install() {
	local my_lib="/usr/share/debhelper/dh_make"
	dobin dh_make
	dodir "${my_lib}"
	cp -r lib/* "${D}${my_lib}" || die "failed copying lib/*"
	doman dh_make.1
}
