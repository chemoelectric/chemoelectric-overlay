# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools pax-utils git-r3

DESCRIPTION="Poly/ML is a full implementation of Standard ML"
HOMEPAGE="https://www.polyml.org"

EGIT_REPO_URI="https://github.com/polyml/polyml.git"

# Possibly clone a ‘fixes’ branch. For instance, for
# polyml-5.7.1.9999, clone the ‘fixes-5.7.1’ branch.
$(ver_test -lt 9999) && EGIT_BRANCH="fixes-${PV/\.9999*/}"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="X elibc_glibc +gmp portable test +threads"

RDEPEND="X? ( x11-libs/motif:0 )
		gmp? ( >=dev-libs/gmp-5 )
		elibc_glibc? ( threads? ( >=sys-libs/glibc-2.13 ) )
		virtual/libffi"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--enable-shared \
		--disable-static \
		--with-system-libffi \
		$(use_with X x) \
		$(use_with gmp) \
		$(use_with portable) \
		$(use_with threads)
}

src_compile() {
	# Bug 453146 - dev-lang/polyml-5.5.0: fails to build (pax kernel?)
	pushd libpolyml || die "Could not cd to libpolyml"
	emake
	popd
	emake polyimport
	pax-mark m "${S}/.libs/polyimport"
	emake
	emake compiler
	pax-mark m "${S}/.libs/poly"
}

src_test() {
	emake tests || die "tests failed"
}