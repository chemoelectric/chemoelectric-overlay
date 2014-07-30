# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Schily's make"
HOMEPAGE="https://sourceforge.net/projects/s-make/"
SRC_URI="mirror://sourceforge/s-make/${P}.tar.bz2"
LICENSE="CDDL-Schily"

SLOT="0"

KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_configure() {
	:
}

src_install() {
	emake INS_BASE="${D}usr" install

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
