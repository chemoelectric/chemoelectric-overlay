# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# FIXME: This ebuild has no support for deprecated but still widely
# used Guile 1.8, and indeed, at the time of writing, is dependent on
# the ‘lisp’ overlay for Guile 2.0 support.

# FIXME: It may end up that AutoGen still is using deprecated Guile
# features. If so, we should add [deprecated] as a required USE flag
# of dev-scheme/guile.

# FIXME: We do not actually use this software and do not know if it is
# working according to design. (Indeed, it is easy to get xml2ag to
# crash.) So this is really a work in progress.

EAPI=5

inherit eutils

DESCRIPTION="Program and text file generation"
HOMEPAGE="http://www.gnu.org/software/autogen/"
SRC_URI="mirror://gnu/${PN}/rel${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libopts static-libs"

RDEPEND=">=dev-scheme/guile-2.0.9
	dev-libs/libxml2"
DEPEND="${RDEPEND} virtual/pkgconfig"

src_configure() {
	# suppress possibly incorrect -R flag
	export ag_cv_test_ldflags=

	econf $(use_enable static-libs static) \
		--with-libguile-cflags="$(pkg-config --cflags guile-2.0)" \
		--with-libguile-libs="$(pkg-config --libs guile-2.0)" \
		--with-guile-ver="$(pkg-config --modversion guile-2.0)"
}

src_install() {
	default
	prune_libtool_files

	if ! use libopts ; then
		rm "${ED}"/usr/share/autogen/libopts-*.tar.gz || die
	fi
}
