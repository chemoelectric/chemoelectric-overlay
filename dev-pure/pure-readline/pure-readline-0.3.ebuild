# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pure-lang

DESCRIPTION="Pure readline interface"
LICENSE="GNUAllPermissive"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#
# FIXME: Have this use libedit instead of readline, if Pure is
# compiled with libedit.
#

RDEPEND="dev-lang/pure
	     sys-libs/readline"
DEPEND="${RDEPEND}"
