# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Algol 68 Genie"
HOMEPAGE="http://jmvdveer.home.xs4all.nl/algol.html"
SRC_URI="http://jmvdveer.home.xs4all.nl/${P}.tar.gz"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="+compiler ncurses readline gsl +parallel plotutils postgres"

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
