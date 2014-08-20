# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# OpenCOBOL now is GNU COBOL, so I have adapted the ebuild to reflect
# this fact. Presumably Gentoo will make similar changes for future
# versions.

inherit eutils

DESCRIPTION="GNU COBOL compiler"
HOMEPAGE="https://sourceforge.net/projects/open-cobol/"
SRC_URI="mirror://sourceforge/open-cobol/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="berkdb nls readline"

RDEPEND="dev-libs/gmp
	berkdb? ( =sys-libs/db-4* )
	sys-libs/ncurses
	readline? ( sys-libs/readline )
	!dev-lang/open-cobol"
DEPEND="${RDEPEND}
	sys-devel/libtool"

src_configure() {
	econf \
		$(use_with berkdb db) \
		$(use_enable nls) \
		$(use_with readline)
}
