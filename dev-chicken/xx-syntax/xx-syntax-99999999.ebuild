# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mercurial
inherit chicken-egg

DESCRIPTION="More ways to make macro transformers for Chicken Scheme"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/xx-syntax"
SRC_URI=""
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="MIT"
SLOT="0/0"
KEYWORDS=""

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/utf8
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/srfi42
	dev-chicken/matchable
"
