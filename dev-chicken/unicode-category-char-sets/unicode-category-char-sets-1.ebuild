# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Character sets for Unicode categories"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/unicode-category-char-sets"
SRC_URI="
	mirror://sourceforge/project/chemoelectric/${PN}/${P}.tar.gz
		-> chicken-${P}.tar.gz
"

LICENSE="GPL-3+ unicode-data-files-and-software"
SLOT="0/${PV}"
KEYWORDS="~amd64"

S="${WORKDIR}/${P}"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/utf8
	dev-chicken/iset
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/srfi1
	dev-chicken/srfi42
	dev-chicken/matchable
"
