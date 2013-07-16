# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="scripts to make the life of a Debian Package maintainer easier"
HOMEPAGE="http://packages.debian.org/wheezy/${PN}"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT=test

# FIXME: Dependencies.
RDEPEND="dev-util/checkbashisms"
DEPEND="${RDEPEND}"

src_prepare () {
	epatch "${FILESDIR}/${P}.patch"
}

src_install () {
	default
	find ${D} -name 'checkbashisms*' -exec rm {} \;
}
