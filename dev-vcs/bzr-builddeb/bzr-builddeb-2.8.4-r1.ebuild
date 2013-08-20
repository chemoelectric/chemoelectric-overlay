# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# FIXME: Is this supposed to work for multiple python versions?
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="bzr plugin for Debian package management"
HOMEPAGE="https://launchpad.net/ubuntu/raring/+source/${PN}"
SRC_URI="https://launchpad.net/ubuntu/raring/+source/${PN}/${PV}/+files/${PN}_${PV}.tar.gz"
LICENSE="GPL-2+"

SLOT="0"

KEYWORDS="~amd64"

DEPEND="dev-vcs/bzr"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV}"
