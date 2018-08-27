# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils autotools

# FIXME: One get a QA Notice for CBL_OC_DUMP.so being pre-stripped.

# FIXME: USE=code-coverage might be disabled in some versions of
#        GnoCOBOL, due to ‘compatibility issues’.

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="GNU COBOL compiler"
HOMEPAGE="https://sourceforge.net/projects/open-cobol/"
SRC_URI="mirror://sourceforge/open-cobol/${MY_P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="berkdb code-coverage nls"

S="${WORKDIR}/${MY_P}"

RDEPEND="
	dev-libs/gmp:=
	berkdb? ( =sys-libs/db-4*:= )
	code-coverage? ( dev-util/lcov:* )
	sys-libs/ncurses:=
	!dev-lang/open-cobol
	!dev-lang/gnu-cobol
"
DEPEND="
	${RDEPEND}
	sys-devel/libtool
"

src_prepare() {
	eapply_user
	sed -i 's|rm -f $(includedir)/libcob/|rm -f $(DESTDIR)$(includedir)/libcob/|' \
		libcob/Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_with berkdb db) \
		$(use_enable code-coverage) \
		$(use_enable nls)
}
