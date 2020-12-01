# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="SRFI-74: Octet-Addressed Binary Blocks"

LICENSE="MIT"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi60:=
	dev-chicken/srfi66:=
"
DEPEND="${RDEPEND}"
