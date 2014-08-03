# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
#PYTHON_COMPAT=( python{2_{6,7},3_{1,2,3}} )
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="Python interface to libapt-pkg"
HOMEPAGE="http://packages.debian.org/sid/${PN}"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.tar.xz"
LICENSE="GPL-2+"

SLOT="0"

#KEYWORDS="~amd64"
KEYWORDS=""

DEPEND="
	dev-lang/python
	>=sys-apps/apt-0.9.7.9
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV}"
