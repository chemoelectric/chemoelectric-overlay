# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A wrapper around Subversion's libsvn_client C library"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-vcs/subversion-1.14.0-r1:=
	>=dev-scheme/chicken-5.2.0:=
"
DEPEND="${RDEPEND}"
