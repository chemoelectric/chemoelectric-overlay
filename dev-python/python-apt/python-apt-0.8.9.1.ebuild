# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Python interface to libapt-pkg"
HOMEPAGE="http://packages.debian.org/sid/${PN}"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2+"

SLOT="0"

KEYWORDS="~amd64"

DEPEND="
    dev-lang/python
    >=sys-apps/apt-0.8.11
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV}"
