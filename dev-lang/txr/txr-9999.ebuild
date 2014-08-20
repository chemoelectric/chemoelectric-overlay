# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Text scraping and data munging language"
HOMEPAGE="http://www.nongnu.org/txr/"
EGIT_REPO_URI="http://kylheku.com/git/${PN}"
LICENSE="BSD-2"

SLOT="0"
KEYWORDS=""
IUSE=""

# "Dinosaur" Yacc fails, at least for me (20 August 2014). Berkeley
# Yacc and Bison both work, however, as does plan9port Yacc. Let us
# use Bison, because I suspect that is the more likely to be installed
# already. (To me it hardly seems worth providing a USE flag for
# this.)
DEPEND="sys-devel/bison"
RDEPEND=""

MY_YACC='bison -y'

src_configure() {
	# This is not a GNU Autoconf-generated configure script.
	./configure --prefix=/usr --yacc="${MY_YACC}" \
		|| die "configure failed"
}

src_test() {
	emake tests
}

src_install() {
	emake install DESTDIR="${ED}"
	dodoc RELNOTES HACKING
}
