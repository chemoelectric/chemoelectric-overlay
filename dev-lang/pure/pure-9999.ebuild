# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pure-lang eutils autotools

# FIXME: Add support for the TeXmacs plugin.

DESCRIPTION="A modern-style functional programming language based on term rewriting"
LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS=""

IUSE="doc examples emacs libedit mpir readline static-llvm"

DEPEND="
	>=sys-devel/llvm-3.2
	>=dev-libs/mpfr-3.0.1_p4
	emacs? ( virtual/emacs )
	libedit? ( >=dev-libs/libedit-20110709.3.0 )
	mpir? ( >=sci-libs/mpir-2.3.1 )
	!mpir? ( >=dev-libs/gmp-5.0.2_p1 )
	readline? ( >=sys-libs/readline-6.2_p1 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	# Use relative links for shared library versions. The unaltered
	# Makefile.in results in absolute links.
	sed -i -e 's#\(ln -sf \)\$(libdir)/\(\$(libpure) \$(DESTDIR)\$(libdir)/\$(libpure_\(so\|\lnk\)name)\)#\1\2#' \
		"${S}/Makefile.in" || die "failed to fix shared library links"

	eautoreconf
}

src_configure() {
	if ! use static-llvm ; then
		LDFLAGS="-Wl,-rpath -Wl,/usr/$(get_libdir) -Wl,-rpath -Wl,/usr/$(get_libdir)/llvm ${LDFLAGS}"
	fi
	econf --enable-release \
		$(use_with emacs elisp) \
		$(use_with libedit editline) \
		$(use_with mpir) \
		$(use_with readline) \
		$(use_with static-llvm)
}

src_install() {
	default
	use doc && dodoc pure.txt
	use examples && dodoc -r examples
}

pkg_postinst() {
	elog "The full documentation for the Pure language"
	elog "has been moved to \`dev-lang/pure-docs'."
}
