# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit rpm

DESCRIPTION="Gaigen 2.5, a code generator for geometric algebra"
HOMEPAGE="http://g25.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-1.noarch.rpm"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# FIXME: Possibly add an option to build from sources rather than
# install the pre-compiled C#.
#
# FIXME: Specify somehow that you might want to have antlr installed.

DEPEND=""
RDEPEND=">=dev-lang/mono-2.10.5"

S="${WORKDIR}"

src_install() {
	cp -r usr ${D} || die "recursive copy failed"
	dodoc usr/share/g25/doc/g25_user_manual.pdf
	rm -f ${D}usr/share/doc/g25_user_manual.pdf
	dosym /usr/share/doc/${PF}/g25_user_manual.pdf /usr/share/g25/doc/g25_user_manual.pdf
}
