# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Useful tools for Ubuntu developers"
HOMEPAGE="https://launchpad.net/${PN}"
SRC_URI="https://launchpad.net/debian/sid/+source/${PN}/${PV}/+files/${PN}_${PV}.tar.gz"
LICENSE="GPL-2 GPL-2+ GPL-3 GPL-3+"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    >=dev-util/pbuilder-0.215
    >=dev-python/python-apt-0.8.9.1
    dev-python/setuptools
    dev-python/pylint
    dev-python/httplib2
    dev-python/mox
    dev-python/soappy
    virtual/python-unittest2
    dev-perl/libwww-perl
    sys-apps/lsb-release
"
DEPEND="
    ${RDEPEND}
"
