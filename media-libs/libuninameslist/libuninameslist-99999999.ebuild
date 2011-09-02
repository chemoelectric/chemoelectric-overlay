# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libuninameslist/libuninameslist-20080409.ebuild,v 1.11 2010/01/15 09:43:44 fauli Exp $

EAPI=4
ECVS_SERVER="${PN}.cvs.sourceforge.net:/cvsroot/${PN}"
ECVS_MODULE="src"
ECVS_TOPDIR="${DISTDIR}/cvs-src/${PN}"

inherit autotools eutils cvs

DESCRIPTION="Library of unicode annotation data"
HOMEPAGE="http://${PN}.sourceforge.net/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/${ECVS_MODULE}"

src_prepare() {
	epatch "${FILESDIR}/${PN}.2011.09.01.18.49.10.patch"
	eautoconf
}
