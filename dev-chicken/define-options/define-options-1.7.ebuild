# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Conveniently bind to getopt-long options"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/tree:=
	dev-chicken/brev-separate:=
	dev-chicken/getopt-long:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
