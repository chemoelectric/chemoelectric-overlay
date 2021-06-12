# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs
inherit flag-o-matic

DESCRIPTION="The OpenBSD implementation of m4"
HOMEPAGE="https://github.com/openbsd/"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}.tar.bz2"

LICENSE="BSD ISC"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/src.git/usr.bin/m4"

BDEPEND="
	virtual/yacc:*
	sys-devel/flex:*
"
RDEPEND="
	dev-libs/libbsd:=
"
DEPEND="
	${RDEPEND}
"

bsdization()
{
	sed -i \
		-e 's|<stdlib\.h>|<bsd/stdlib.h>|' \
		-e 's|<string\.h>|<bsd/string.h>|' "$@"
}

src_prepare()
{
	default
	eapply -p3 "${FILESDIR}/no-pledge-20120612.patch"
	eapply -p3 "${FILESDIR}/stdlib.h-in-parser.y-20120612.patch"
	bsdization "${WORKDIR}/src.git/usr.bin/m4/"*.[ch] || die
	bsdization "${WORKDIR}/src.git/lib/libutil/"*.[ch] || die
}

src_compile()
{
	flex -o tokenizer.c tokenizer.l || die
	bsdization tokenizer.c || die

	yacc -d parser.y || die
	mv y.tab.c parser.c || die
	mv y.tab.h parser.h || die
	bsdization parser.[ch] || die

	append-cflags $(test-flags-CC -Wno-unused-result)

	echo ${CC-$(tc-getCC)} ${CPPFLAGS} ${CFLAGS} -o m4 \
		 -D__dead= \
		 -I. -I"${WORKDIR}/src.git/lib/libutil/" \
		 *.c "${WORKDIR}/src.git/lib/libutil/"*.c \
		 ${LDFLAGS} -lbsd -lm > my-compile-command.sh
	cat my-compile-command.sh
	sh my-compile-command.sh
	if false;then
	${CC-$(tc-getCC)} ${CPPFLAGS} ${CFLAGS} -o m4 \
					  -D__dead= \
					  -I. -I"${WORKDIR}/src.git/lib/libutil/" \
					  *.c "${WORKDIR}/src.git/lib/libutil/"*.c \
					  ${LDFLAGS} -lbsd -lm || die
	fi
}

src_install()
{
	newbin m4 "${PN}"
	newman m4.1 "${PN}".1
	dodoc NOTES
}
