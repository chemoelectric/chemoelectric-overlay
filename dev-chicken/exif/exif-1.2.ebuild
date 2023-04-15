# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Binding to libexif, reading EXIF meta data from digital camera images"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=media-libs/libexif-0.6.24:=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/foreigners:=
	dev-chicken/srfi13:=
"
DEPEND="${RDEPEND}"
