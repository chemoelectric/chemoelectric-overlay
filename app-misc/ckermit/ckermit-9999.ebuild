# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="C-Kermit"
HOMEPAGE="http://kermit.columbia.edu/"
SRC_URI="
    ftp://www.columbia.edu/kermit/test/tar/x.tar.gz
    http://www.columbia.edu/kermit/ftp/c-kermit/ckermit.ini
"

LICENSE="Kermit"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ssl telnet"

DEPEND="
    >=sys-libs/ncurses-5.9
    ssl? ( >=dev-libs/openssl-1.0.0d )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_configure()
{
    :
}

src_compile()
{
    local target

    target="linux"
    use ssl && target+="+ssl"
    emake "${target}" LIBS="-lcurses"
}

src_install()
{
    newbin wermit kermit
    dosym kermit /usr/bin/kermit-sshsub
    use telnet && dosym kermit /usr/bin/telnet

    cp "${DISTDIR}/ckermit.ini" ckermit.ini || die "${DISTDIR}/ckermit.ini not found"
    edo sed -i -e '1i#!/usr/bin/kermit\n' ckermit.ini
    dobin ckermit.ini

    newman ckuker.nr kermit.1
    dodoc *.txt
}

