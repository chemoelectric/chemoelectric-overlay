# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A binding for libdbus, the IPC mechanism"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi18:=
	dev-chicken/foreigners:=
"
DEPEND="${RDEPEND}"

src_install() {
	chicken-egg_src_install
	use examples && dodoc -r examples
}
