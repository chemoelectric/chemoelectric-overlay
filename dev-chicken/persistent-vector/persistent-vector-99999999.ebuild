# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mercurial
inherit chicken-egg

DESCRIPTION="Persistent vectors (immutable vectors) for Chicken Scheme"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/persistent-vector"
SRC_URI=""
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="GPL-3+"
SLOT="0/0"
KEYWORDS=""

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/r7rs
	dev-chicken/srfi42
	dev-chicken/format
	dev-chicken/matchable
"
DEPEND="${RDEPEND}"
