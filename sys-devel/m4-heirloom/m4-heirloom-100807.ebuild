# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="The Heirloom Development Tools implementation of m4"
HOMEPAGE="http://heirloom.sourceforge.net/devtools.html"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/heirloom-devtools-${PV}.tar.bz2"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64"

MY_TOPDIR="${WORKDIR}/heirloom-devtools"

S="${MY_TOPDIR}/m4"

BDEPEND="
	virtual/yacc:*
"

src_prepare()
{
	eapply -p2 "${FILESDIR}/format-100807.patch"
	eapply_user
}

my_emake()
{
	emake -f Makefile.mk \
		  YACC=yacc \
		  CC="$(tc-getCC)" \
		  CFLAGS="${CFLAGS}" \
		  CPPFLAGS="${CPPFLAGS}" \
		  WARN= \
		  "$@"
}

src_compile()
{
	my_emake m4y.c
	my_emake m4y_xpg4.c
	my_emake
}

src_install()
{
	newbin m4 m4-heirloom
	newbin m4_xpg4 m4_xpg4-heirloom
	dodoc "${MY_TOPDIR}"/{README,CHANGES}
}
