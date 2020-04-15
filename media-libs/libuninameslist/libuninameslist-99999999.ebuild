# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
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
	default
	eapply "${FILESDIR}/${PN}.2011.09.01.18.49.10.patch"
	eautoconf
}
