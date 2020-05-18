# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
inherit common-lisp-3

DESCRIPTION="Helper library for Closure and Closure XML implementing runes."
HOMEPAGE="http://www.cliki.net/closure-common"
EGIT_REPO_URI="https://repo.or.cz/${PN}.git"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-lisp/trivial-gray-streams"
