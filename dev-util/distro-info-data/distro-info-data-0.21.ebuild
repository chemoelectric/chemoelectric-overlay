# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Information about Debian and Ubuntu distributions' releases (data files)"
HOMEPAGE="http://packages.debian.org/sid/distro-info-data"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.xz"
LICENSE="ISC"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-admin/eselect-debian-origin-1"
DEPEND="${RDEPEND}"
