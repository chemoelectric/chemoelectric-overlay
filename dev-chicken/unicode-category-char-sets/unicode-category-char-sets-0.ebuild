# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Character sets for Unicode categories"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/${PN}"
SRC_URI="
	mirror://sourceforge/project/chemoelectric/${PN}/${P}.tar.xz
		-> chicken-${P}.tar.xz
"

LICENSE="GPL-3+ unicode-data-files-and-software"
SLOT="0/5"
KEYWORDS="~amd64"

S="${WORKDIR}/${P}"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/utf8
	dev-chicken/srfi42
	dev-chicken/matchable
	dev-chicken/iset
"
DEPEND="${RDEPEND}"
