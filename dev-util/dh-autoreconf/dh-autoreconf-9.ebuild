# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="debhelper add-on to call autoreconf and clean up after the build"
HOMEPAGE="http://packages.debian.org/dh-autoreconf"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2+"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

src_compile() {
	pod2man --section=1 dh_autoreconf dh_autoreconf.1
	pod2man --section=1 dh_autoreconf_clean dh_autoreconf_clean.1
	pod2man --section=7 dh-autoreconf.pod dh-autoreconf.7
}

src_install() {
	local perllibdir="`perl -MConfig -e 'print $Config{vendorlib}'`/Debian/Debhelper"

	dobin dh_autoreconf dh_autoreconf_clean
	doman dh_autoreconf.1 dh_autoreconf_clean.1 dh-autoreconf.7

	insinto "${perllibdir}/Sequence"
	doins autoreconf.pm

	insinto /usr/share/cdbs/1/rules
	doins autoreconf.mk

	insinto /usr/share/dh-autoreconf
	doins ltmain-as-needed.diff
}
