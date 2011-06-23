# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="a Unix utility for tracking down wasted disk space"

HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/${PN}/"
SRC_URI="http://www.chiark.greenend.org.uk/~sgtatham/${PN}/${PN}-r${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-r${PV}"
