# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Procedures memoization"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"

src_prepare() {
	chicken-egg_src_prepare

	# The egg file has an error in it.
	sed -i -e '/(version "0.1")/d' "${PN}.egg"
}

src_install() {
	chicken-egg_src_install
	dodoc *.wiki
}
