# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="TAR file format packing and unpacking"

LICENSE="LGPL-2.1+"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc2:=
	dev-chicken/miscmacros:=
"
DEPEND="${RDEPEND}"
