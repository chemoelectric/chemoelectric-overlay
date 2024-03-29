# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Allegro 5.0 bindings for Chicken"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/allegro:5=
	>=dev-scheme/chicken-5.2.0:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/foreigners:=
"
