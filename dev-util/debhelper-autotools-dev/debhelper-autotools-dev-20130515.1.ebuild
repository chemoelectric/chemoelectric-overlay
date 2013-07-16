# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DEBIAN_PN="autotools-dev"

DESCRIPTION="Update Debian infrastructure for config.{guess,sub} files"
HOMEPAGE="http://packages.debian.org/sid/${DEBIAN_PN}"
SRC_URI="mirror://debian/pool/main/a/${DEBIAN_PN}/${DEBIAN_PN}_${PV}.tar.gz"
LICENSE="GPL-3+"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-util/debhelper"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${DEBIAN_PN}-${PV}"

src_compile() {
	pod2man -c Debhelper debian/dh_autotools-dev_updateconfig  debian/dh_autotools-dev_updateconfig.1
    pod2man -c Debhelper debian/dh_autotools-dev_restoreconfig debian/dh_autotools-dev_restoreconfig.1
}

src_install() {
	local perllibdir="`perl -MConfig -e 'print $Config{vendorlib}'`/Debian/Debhelper"

	dobin debian/dh_autotools-dev_updateconfig debian/dh_autotools-dev_restoreconfig
	doman debian/dh_autotools-dev_updateconfig.1 debian/dh_autotools-dev_restoreconfig.1
    dodoc debian/changelog

	insinto "${perllibdir}/Sequence"
	doins debian/autotools_dev.pm

	insinto /usr/share/misc
	doins config.guess config.sub
}
