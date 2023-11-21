# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Chicken bindings for the Imlib2 image library"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/imlib2:=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/foreigners:=
"
DEPEND="${RDEPEND}"
