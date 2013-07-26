# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="create and verify signatures on .deb-files"
HOMEPAGE="http://packages.debian.org/dpkg-sig"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2+"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-lang/perl
	dev-perl/Config-File
"
DEPEND="${RDEPEND}"

my_pod2man() {
	pod2man									\
		--release="Debian Project"			\
		--center="Debian GNU/Linux manual"	\
		"${@}"
}

src_compile() {
	my_pod2man --section=1 ${PN}.pod ${PN}.1
	my_pod2man --section=7 ${PN} ${PN}.7
}

src_install() {
	dobin ${PN}
	doman ${PN}.1 ${PN}.7
	dodoc TODO copyright debian/changelog

	insinto /usr/share/lintian/overrides
	newins debian/lintian.overrides ${PN}
}
