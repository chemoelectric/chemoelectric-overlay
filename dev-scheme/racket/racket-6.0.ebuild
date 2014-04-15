# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="Racket is a general-purpose programming language with strong support for domain-specific languages."
HOMEPAGE="http://racket-lang.org/"
SRC_URI="http://mirror.racket-lang.org/installers/${PV}/${P}-src-unix.tgz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="backtrace cairo doc futures jit places plot threads X"
IUSE="cairo doc futures jit places plot threads X"

RDEPEND="dev-db/sqlite:3 x11-libs/cairo[X?] virtual/libffi"

# see bug 426316: racket/draw (which depends on cairo) is sometimes used in compile-time code or when rendering documentation
DEPEND="${RDEPEND} x11-libs/cairo !dev-tex/slatex"

EGIT_SOURCEDIR="${WORKDIR}/${P}"
S="${WORKDIR}/${P}/src"

src_prepare() {
	#remove bundled libraries
	rm -rf foreign/libffi/

	sed -e "s,docdir=\"\${datadir}/${PN}/doc,docdir=\"\${datadir}/doc/${PF}," -i configure || die
}

src_configure() {
	# ‘backtrace’ causes segfault during installation, for us, so we
	# disable it unconditionally, even though the ebuilds in Portage
	# provide it as a USE flag.
	econf \
		$(use_enable X gracket) \
		$(use_enable jit) \
		$(use_enable futures) \
		$(use_enable places) \
		$(use_enable doc docs) \
		$(use_enable threads pthread) \
		--enable-shared \
		--enable-foreign \
		--enable-libs \
		--enable-libffi \
		--disable-backtrace \
		--disable-strip
}

src_install() {
	# Style file for use with /usr/bin/slatex, which is installed by
	# Racket.
	insinto /usr/share/texmf/tex/latex/slatex/
	doins ../share/pkgs/slatex/slatex.sty

	emake DESTDIR="${D}" install

	ls "${D}"/usr/share/applications/*.desktop > /dev/null 2> /dev/null && {
		sed -i -e "s|${D}||g" "${D}"/usr/share/applications/*.desktop || {
			die "modification of desktop files failed"
		}
	}
}
