# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="scripts to make the life of a Debian Package maintainer easier"
HOMEPAGE="http://packages.debian.org/wheezy/${PN}"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV%_p[1-9]}+deb7u2.tar.gz"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT=test

# FIXME: Dependencies.
RDEPEND="dev-util/checkbashisms"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P%_p[1-9]}+deb7u2"

src_prepare () {
	epatch "${FILESDIR}/${P}.patch"
}

src_install () {
	default
	find "${D}" -name 'checkbashisms*' -exec rm {} \;
}
