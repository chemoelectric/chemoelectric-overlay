# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit elisp

ARCHIVE_PN="emacs-goodies-el"

DESCRIPTION="Emacs helpers specific to Debian development"
HOMEPAGE="http://packages.debian.org/search?keywords=dpkg-dev-el"
SRC_URI="mirror://debian/pool/main/e/${ARCHIVE_PN}/${ARCHIVE_PN}_${PV}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="app-emacs/debian-el"
DEPEND="${RDEPEND}"

MY_TOPDIR="${WORKDIR}/${ARCHIVE_PN}-${PV}"
S="${MY_TOPDIR}/elisp/${PN}"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	/bin/sh ${PN}-loaddefs.make || die "${PN}-loaddefs.make failed"
	elisp_src_prepare
}

src_install() {
	elisp_src_install
	dodoc "${MY_TOPDIR}"/debian/{{,${PN}.}README.Debian,${PN}.copyright}
}
