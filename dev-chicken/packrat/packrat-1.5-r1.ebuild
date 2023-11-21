# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A packrat parsing library"

SRC_URI="
	${SRC_URI}
	doc? (
			http://bugs.call-cc.org/export/20226/release/4/${PN}/doc/${PN}.pdf ->
				${P}.pdf
		 )
"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

IUSE="doc"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"

src_install() {
	chicken-egg_src_install
	if use doc; then
		newdoc "${DISTDIR}/${P}.pdf" "${PN}.pdf"
	fi
}
