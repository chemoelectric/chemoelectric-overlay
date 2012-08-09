# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs multilib

DESCRIPTION="FUSE filesystem for mounting VirtualBox virtual drives"
HOMEPAGE="http://packages.debian.org/sid/virtualbox-fuse"
SRC_URI="mirror://debian/pool/main/v/virtualbox/virtualbox_${PV}-dfsg-1.debian.tar.gz
         http://download.virtualbox.org/virtualbox/${PV}/VirtualBox-${PV}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="=app-emulation/virtualbox-4.1.18*"
RDEPEND="${DEPEND}"

S="${WORKDIR}/debian/vdfuse"

src_install() {
	local include="${WORKDIR}/VirtualBox-${PV}/include"

	# This is done in src_install to get root privileges, because
	# VBoxDDU.so is inaccessible to non-root users who are not members
	# of group vboxusers.
	$(tc-getCC) -g vdfuse.c -o vdfuse \
		`pkg-config --cflags --libs fuse` \
	   	-l:/usr/$(get_libdir)/virtualbox/VBoxDDU.so \
		-Wl,-rpath,/usr/$(get_libdir)/virtualbox \
		-pthread -I"${include}" || die "compilation failed"

	dobin vdfuse
}
