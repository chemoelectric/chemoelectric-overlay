# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Personal package builder for Debian packages"
HOMEPAGE="http://packages.debian.org/sid/pbuilder"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2+"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=sys-apps/debianutils-4.3.4
	>=dev-util/debootstrap-1.0.52
	>=app-arch/dpkg-1.16.10
	net-misc/wget
	>=dev-util/devscripts-2.12.6
	>=sys-apps/fakeroot-1.18.4
	>=app-admin/sudo-1.8.6_p7
"
DEPEND="
	${RDEPEND}
	>=app-text/dblatex-0.3.4
"

src_prepare() {
	epatch "${FILESDIR}/${P}.patch"
}
