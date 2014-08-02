# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Provides information about Debian and Ubuntu distributions' releases"
HOMEPAGE="http://packages.debian.org/sid/distro-info"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.xz"
LICENSE="ISC"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=">=dev-util/distro-info-data-0.21"
DEPEND="${RDEPEND}
	test? ( dev-util/shunit2 )
"

src_prepare () {
	epatch "${FILESDIR}/${P}.patch"
}
