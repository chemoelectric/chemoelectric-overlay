# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="Pure FastCGI interface"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/pure-0.52
         >=dev-libs/fcgi-2.4.1_pre0311112127"
DEPEND="${RDEPEND}"
