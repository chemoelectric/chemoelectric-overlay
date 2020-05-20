# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="The modif parts of the sxml-tools from the SSAX project at Sourceforge"

LICENSE="public-domain"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-scheme/chicken-srfi1-1.4:=
	>=dev-scheme/chicken-sxpath-1.0:=
"
DEPEND="${RDEPEND}"
