# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils versionator

CKUVERSION="$(get_version_component_range 3)"
CKUDEVVERS="$(get_version_component_range 4)"
CKUDEVVERS="${CKUDEVVERS/pre/dev}"
CKUDOCVERS=302

DESCRIPTION="C-Kermit"
HOMEPAGE="http://www.kermitproject.org/"
SRC_URI="
	ftp://ftp.kermitproject.org/kermit/archives/cku${CKUDOCVERS}txt.tar.gz
	ftp://ftp.kermitproject.org/kermit/test/tar/cku${CKUVERSION}-${CKUDEVVERS}.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ssl telnet"

RDEPEND="
	>=dev-libs/lockdev-1.0.3.1.5
	sys-libs/ncurses
	virtual/pam
	ssl? ( >=dev-libs/openssl-1.0.0j )
"
DEPEND="${RDEPEND}"

src_unpack() {
	mkdir -p "${S}" || die "failed to make the work directory ${S}"
	cd "${S}"
	unpack ${A}
}

src_configure()
{
	:
}

src_compile()
{
	local target curses

	target="linux"
	use ssl && target+="+ssl"
	emake "${target}" \
		KFLAGS="${CPPFLAGS} ${CFLAGS}" \
		LNKFLAGS="${LDFLAGS}" \
		SSLLIB= \
		LIBS="${LIBS}"
}

src_install()
{
	newbin wermit kermit
	dosym kermit /usr/bin/kermit-sshsub
	use telnet && dosym kermit /usr/bin/telnet

	newman ckuker.nr kermit.1
	dodoc *.TXT *.txt {o,}ckermit.ini
}