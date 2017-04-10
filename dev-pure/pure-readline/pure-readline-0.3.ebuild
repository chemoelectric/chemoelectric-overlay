# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit pure-lang

DESCRIPTION="Pure readline interface"
LICENSE="GNUAllPermissive"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#
# FIXME: Give this a libedit option.
#

RDEPEND="dev-lang/pure
	     sys-libs/readline"
DEPEND="${RDEPEND}"
