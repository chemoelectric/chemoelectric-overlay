# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Automatically generate release-info and a pseudo-\"meta\"-file for eggs in svn"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/spiffy:=
	dev-chicken/uri-common:=
	dev-chicken/svn-client:=
"
DEPEND="${RDEPEND}"
