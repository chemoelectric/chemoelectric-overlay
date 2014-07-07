# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# FIXME: Maybe pick a `best' Python.
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Useful tools for Ubuntu developers"
HOMEPAGE="https://launchpad.net/${PN}"
SRC_URI="https://launchpad.net/debian/sid/+source/${PN}/${PV}/+files/${PN}_${PV}.tar.gz"
LICENSE="GPL-2 GPL-2+ GPL-3 GPL-3+"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-util/pbuilder-0.215
	>=dev-util/distro-info-0.10
	>=dev-python/python-apt-0.8.9.1
	>=dev-python/python-launchpadlib-1.10.2
	dev-python/setuptools
	dev-python/pylint
	dev-python/httplib2
	dev-python/mox
	dev-python/soappy
	dev-perl/libwww-perl
	sys-apps/lsb-release
"
DEPEND="
	${RDEPEND}
"
