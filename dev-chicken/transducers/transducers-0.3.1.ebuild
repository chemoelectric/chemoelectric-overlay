# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Transducers for working with foldable data types"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi133:=
	dev-chicken/srfi143:=
	dev-chicken/srfi160:=
	dev-chicken/check-errors:=
"
DEPEND="${RDEPEND}"
