# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion autotools multilib

DESCRIPTION="An object-oriented extension of the Icon programming language"
HOMEPAGE="http://objecticon.googlecode.com"
ESVN_REPO_URI="${HOMEPAGE}/svn/trunk"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"
IUSE="doc X jpeg png cairo zlib mysql ssl"

COMMON_DEPEND="
	X? ( x11-libs/libX11 x11-libs/libXrender x11-libs/libXft media-libs/fontconfig media-libs/freetype:2 )
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )
	cairo? ( x11-libs/cairo )
	zlib? ( sys-libs/zlib )
	mysql? ( virtual/mysql )
	ssl? ( dev-libs/openssl )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	default
	subversion_wc_info
	sed -i -e 's|`svnversion`|'"${ESVN_WC_REVISION}|" configure.ac \
		|| die "sed failed"
	eautoconf
}

my_use_with() {
	local without=
	use $1 || without="--without-$2"
	printf "%s" "${without}"
}

src_configure() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--libdir=/usr/$(get_libdir) \
		$(my_use_with X X11) \
		$(my_use_with jpeg jpeg) \
		$(my_use_with png png) \
		$(my_use_with cairo cairo) \
		$(my_use_with zlib zlib) \
		$(my_use_with mysql mysql) \
		$(my_use_with ssl openssl) \
		|| die "configure failed"
}

src_compile() {
	default
	use doc && emake libref
}

src_test() {
	emake -j1 test
}

src_install() {
	sed \
		-e "s|^OIBIN=|OIBIN=${D}/|" \
		-e "s|^OILIB=|OILIB=${D}/|" \
		Makefile > Makefile.install \
		|| die "sed failed"
	emake -f Makefile.install install

	dodoc README

	use doc && {
		local docdir="/usr/share/doc/${PF}"
		dodir "${docdir}"
		cp -R libref "${D}${docdir}/html" || die "cp failed"
	}
}
