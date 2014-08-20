# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Algol 68 Genie"
HOMEPAGE="http://jmvdveer.home.xs4all.nl/algol.html"
CHEMOELECTRIC_DOWNLOADS="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads"

# I have packaged the documentation for users myself, because,
# upstream, the file name does not include the a68g version
# number.
#
# The technical manual is the generated from the sources by doxygen,
# but the generating commands seem not to be included in the source
# distribution. Therefore I have packaged the pre-generated PDF;
# again, the file name upstream does not include the a68g version
# number.
SRC_URI="
	http://jmvdveer.home.xs4all.nl/${P}.tar.gz
	doc? ( ${CHEMOELECTRIC_DOWNLOADS}/${PN}.pdf-${PV}.tar.xz
	       ${CHEMOELECTRIC_DOWNLOADS}/a68gtech.pdf-${PV}.tar.xz )
"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="doc +compiler ncurses readline gsl +parallel plotutils postgres"

RDEPEND="
	ncurses? ( sys-libs/ncurses )
	readline? ( sys-libs/readline )
	gsl? ( sci-libs/gsl )
	plotutils? ( media-libs/plotutils )
	postgres? ( dev-db/postgresql-base )
"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_enable compiler) \
		$(use_enable ncurses curses) \
		$(use_enable readline) \
		$(use_enable gsl) \
		$(use_enable parallel) \
		$(use_enable plotutils) \
		$(use_enable postgres postgresql)
}

src_install() {
	emake install docdir="/usr/share/doc/${PF}" DESTDIR="${D}"
	rm -f "${D}/usr/share/doc/${PF}/COPYING" # Redundant.
	dodoc ISSUES
	use doc && dodoc "${WORKDIR}"/{a68gtech,algol68g}.pdf
}
