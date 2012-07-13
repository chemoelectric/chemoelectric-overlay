# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

VERSION="1.2"
QUALIFIER="a49"
FULL_VERSION="${VERSION}${QUALIFIER}"

DESCRIPTION="Schily's make"
HOMEPAGE="http://cdrecord.berlios.de/private/smake.html"
SRC_URI="ftp://ftp.berlios.de/pub/${PN}/alpha/${PN}-${FULL_VERSION}.tar.bz2"
LICENSE="CDDL-Schily"

SLOT="0"

KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${VERSION}/"

src_configure() {
	:
}

src_compile() {
	make COPTX=-DTRY_EXT2_FS || die "make failed"
}

src_install() {
	make INS_BASE="${D}usr" install || die "make install failed"

	# Put manpages in the right place.
	if test -d "${D}usr/man"; then
		dodir "/usr/share"
		mv "${D}usr/man" "${D}usr/share"
	fi

	# Avoid manpage conflicts.
	mv "${D}usr/share/man/man5/makefiles.5" "${D}usr/share/man/man5/makefiles-${PN}.5"
	mv "${D}usr/share/man/man5/makerules.5" "${D}usr/share/man/man5/makerules-${PN}.5"

	# Delete the developer stuff.
	rm -r "${D}usr/lib" "${D}usr/include"
}
