# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs
inherit flag-o-matic

DESCRIPTION="Ratfor77: Ratfor-to-Fortran77 translator"
HOMEPAGE="http://sepwww.stanford.edu/doku.php?id=sep:software:ratfor"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/ratfor77.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}"

PATCHES=( "${FILESDIR}"/ratfor77-19990213.patch )

src_compile()
{
	append-cflags $(test-flags-CC -std=gnu89)
	emake CC="$(tc-getCC)" SIGNED_CHAR='"signed char"' SEPBINDIR=. GNU=yes
}

src_install()
{
	dobin ratfor77
	dodoc README BUGS ratfor.man *.r
}
