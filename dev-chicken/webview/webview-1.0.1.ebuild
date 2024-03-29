# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Multi-platform HTML user interface shell"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
	dev-chicken/utf8:=
"
DEPEND="${RDEPEND}"

src_install() {
	chicken-egg_src_install
	dodoc webview.wiki
}
