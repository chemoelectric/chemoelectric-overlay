# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Launchpad web services client library"
HOMEPAGE="https://launchpad.net/ubuntu/+source/${PN}"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}%2Bds.orig.tar.gz"
LICENSE="LGPL-3"

SLOT="0"

KEYWORDS="~amd64"

DEPEND="
	dev-lang/python
	dev-python/simplejson
	dev-python/httplib2
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/launchpadlib-${PV}"

src_install () {
	distutils_src_install
	dodoc README* HACKING* PKG-INFO
}
