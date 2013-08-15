# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="XML/XSLT interface for Pure"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-lang/pure-0.47
	>=dev-libs/libxml2-2.7.8-r1
	>=dev-libs/libxslt-1.1.26-r1
"
RDEPEND="${DEPEND}"
