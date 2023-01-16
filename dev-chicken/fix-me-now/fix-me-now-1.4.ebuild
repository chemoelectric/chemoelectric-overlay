# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Make tweaks and changes to sexp trees"

LICENSE="BSD-1"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/strse:=
	dev-chicken/srfi1:=
	dev-chicken/sxml-transforms:=
"
DEPEND="${RDEPEND}"
