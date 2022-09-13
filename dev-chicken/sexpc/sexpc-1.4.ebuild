# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Unix filter that turns sexps into C syntax"

LICENSE="BSD-1"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/brev-separate:=
	dev-chicken/fmt:=
	dev-chicken/tree:=
"
DEPEND="${RDEPEND}"
