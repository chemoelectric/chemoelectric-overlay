# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="A small collection of programs to facilitate TCP programming in shell-scripts"
HOMEPAGE="ftp://ftp.lysator.liu.se/pub/unix/tcputils/"

# List both the original site and the chemoelectric overlay's copy. We
# are keeping a copy in case the site disappears.
SRC_URI="
	ftp://ftp.lysator.liu.se/pub/unix/tcputils/${P}.tar.gz
	https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}.tar.gz
"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_prepare() {
	# trivially patch Makefile for using Gentoo CFLAGS etc.
	eapply "${FILESDIR}/${P}-Makefile.patch"
	eapply_user
}

src_install() {
	dobin tcpconnect tcplisten tcpbug mini-inetd getpeername || die
	doman tcpconnect.1 tcplisten.1 tcpbug.1 mini-inetd.1 getpeername.1 || die
	dodoc README || die
}
