# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial
inherit chicken-egg

DESCRIPTION="Monads for Chicken Scheme"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/${PN}"
SRC_URI=""
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS=""

RDEPEND="
	dev-chicken/utf8
	dev-chicken/srfi1
	dev-chicken/srfi69
	dev-chicken/matchable
"
DEPEND="${RDEPEND}"
