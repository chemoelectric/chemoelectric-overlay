# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A tool to convert and keep henrietta's cache in a git repository"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

COMMON_DEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
"
RDEPEND="
	dev-vcs/git
	${COMMON_DEPEND}
"
DEPEND="
	${COMMON_DEPEND}
"
