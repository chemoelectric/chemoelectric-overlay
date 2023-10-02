# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="low-level event loop management library for POSIX-based operating systems"
HOMEPAGE="https://www.lysator.liu.se/liboop/"
SRC_URI="https://ftp.lysator.liu.se/pub/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

# net-libs/adns is being removed from Gentoo, so let us simply
# remove support for it from liboop, as we keep it alive.
# (Mind you, I do not know why I have liboop installed.
# I might not be using it for anything. It just did not seem
# good to let the ebuild go away.
#
#IUSE="adns gnome tcl readline"
IUSE="gnome tcl readline"

#	adns? ( net-libs/adns )
DEPEND="
	gnome? ( dev-libs/glib:2 )
	tcl? ( dev-lang/tcl:0 )
	readline? ( sys-libs/readline:0 )"

src_configure() {
	export ac_cv_path_PROG_LDCONFIG=true
	econf \
		$(use_with gnome glib) \
		$(use_with tcl) \
		$(use_with readline) \
		--without-libwww \
		--disable-static \
		--without-adns
	# $(use_with adns)
}

src_compile() {
	emake -j1
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
