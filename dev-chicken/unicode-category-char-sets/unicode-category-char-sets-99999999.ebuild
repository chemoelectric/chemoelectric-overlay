# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mercurial
inherit chicken-egg

DESCRIPTION="Character sets for Unicode categories"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/unicode-category-char-sets"
SRC_URI=""
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="GPL-3+ unicode-data-files-and-software"
SLOT="0/0"
KEYWORDS=""

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/iset
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/utf8
	dev-chicken/srfi1
	dev-chicken/srfi42
	dev-chicken/matchable
"
