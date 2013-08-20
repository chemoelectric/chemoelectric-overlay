# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="Pure readline interface"
LICENSE="GNUAllPermissive"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/pure-0.56
	     >=sys-libs/readline-6.2_p1"
DEPEND="${RDEPEND}"
