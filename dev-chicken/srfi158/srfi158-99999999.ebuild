# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial
inherit chicken-egg

SRFI=${PN/srfi/srfi-}

DESCRIPTION="SRFI 158: Generators and Accumulators"
HOMEPAGE="https://srfi.schemers.org/${SRFI}/${SRFI}.html"
SRC_URI=""
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/srfi-158"

LICENSE="MIT"
SLOT="0/5"
KEYWORDS=""

IUSE=""

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/big-chicken
"
DEPEND="${RDEPEND}"
