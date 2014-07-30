# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang

DESCRIPTION="Pure interface to C++ STL maps"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/pure-0.53"
DEPEND="${RDEPEND}"

# FIXME: I think the tests need rework.
RESTRICT=test