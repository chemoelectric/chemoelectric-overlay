# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="SRFI 160: Homogeneous numeric vector libraries"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi128:=
"
DEPEND="${RDEPEND}"

# The egg file has a bug.
PATCHES=( "${FILESDIR}/${P}.patch" )
