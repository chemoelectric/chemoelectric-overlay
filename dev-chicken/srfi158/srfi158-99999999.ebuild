# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
inherit chicken-egg

SRFI=${PN/srfi/srfi-}

DESCRIPTION="SRFI 158: Generators and Accumulators"
HOMEPAGE="https://srfi.schemers.org/${SRFI}/${SRFI}.html"
SRC_URI=""
EGIT_REPO_URI="https://github.com/scheme-requests-for-implementation/${SRFI}.git"

LICENSE="MIT"
SLOT="0/5"
KEYWORDS=""

IUSE=""

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/big-chicken
"
DEPEND="${RDEPEND}"

PATCHES=(
	#
	# FIXME: do not apply the patch, until we have testing working.
	#
	#"${FILESDIR}"/chicken-test.scm.chicken5.patch
)

S="${WORKDIR}/${P}"

src_prepare() {
	mv ${SRFI}.scm{,.ORIG} || die
	cp "${FILESDIR}"/${SRFI}.scm.chicken5 ${SRFI}.scm
	cp "${FILESDIR}"/${SRFI}.egg.chicken5 ${SRFI}.egg
	chicken-egg_src_prepare
}
