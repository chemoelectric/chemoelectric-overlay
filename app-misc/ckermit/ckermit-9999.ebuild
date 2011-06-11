# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="C-Kermit"
HOMEPAGE="http://kermit.columbia.edu/"
SRC_URI=""

LICENSE="Kermit"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ssl telnet"

RDEPEND="
    >=sys-libs/ncurses-5.9
    ssl? ( >=dev-libs/openssl-1.0.0d )
"
DEPEND="
    ${RDEPEND}
    app-arch/gzip
    app-arch/tar
    net-misc/wget
"

S="${WORKDIR}"

src_unpack()
{
	local x_url ini_url
	x_url="ftp://www.columbia.edu/kermit/test/tar/x.tar.gz"
	ini_url="http://www.columbia.edu/kermit/ftp/c-kermit/ckermit.ini"
	wget "${x_url}" || die "wget ${x_url} failed"
	wget "${ini_url}" || die "wget ${ini_url} failed"
	(gzip -d < x.tar.gz | tar xf -) || die "untarring failing"
}

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

    sed -i -e '1i#!/usr/bin/kermit\n' ckermit.ini || die "sed failed"
    dobin ckermit.ini

    newman ckuker.nr kermit.1
    dodoc *.txt
}

