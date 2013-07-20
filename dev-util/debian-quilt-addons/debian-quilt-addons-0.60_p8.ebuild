# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Add-ons from Debian's quilt packaging"
HOMEPAGE="http://foo.example.org/"
SRC_URI="mirror://debian/pool/main/q/quilt/quilt_0.60-8.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/debian"

src_compile() {
	pod2man -c Debhelper dh_quilt_patch dh_quilt_patch.1
	pod2man -c Debhelper dh_quilt_unpatch dh_quilt_unpatch.1
}

src_install() {
	local perllibdir="`perl -MConfig -e 'print $Config{vendorlib}'`/Debian/Debhelper"

	dobin deb3 dh_quilt_patch dh_quilt_unpatch

	doman deb3.1 dh_quilt_patch.1 dh_quilt_unpatch.1

	dodoc README*

	insinto /usr/share/quilt
	doins quilt.debbuild.mk
	doins quilt.make

	insinto /usr/share/cdbs/1/rules
	doins patchsys-quilt.mk

	insinto "${perllibdir}"
	doins quilt.pm
}
