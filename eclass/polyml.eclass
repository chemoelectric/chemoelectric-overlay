# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit autotools pax-utils

DESCRIPTION="Poly/ML is a full implementation of Standard ML"
HOMEPAGE="https://www.polyml.org"

if [[ "${POLYML_LIVE_EBUILD}" == "yes" ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/polyml/polyml.git"

	# Possibly clone a ‘fixes’ branch. For instance, for
	# polyml-5.7.1.9999, clone the ‘fixes-5.7.1’ branch.
	$(ver_test -lt 9999) && EGIT_BRANCH="fixes-${PV/\.9999*/}"
else
	SRC_URI="https://github.com/polyml/polyml/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="LGPL-2.1"
IUSE="X compact32bit elibc_glibc +gmp +native-codegeneration test +threads"

RDEPEND="X? ( x11-libs/motif:0 )
		gmp? ( >=dev-libs/gmp-5 )
		elibc_glibc? ( threads? ( >=sys-libs/glibc-2.13 ) )
		virtual/libffi"
DEPEND="${RDEPEND}"

polyml_src_prepare() {
	default
	eautoreconf
}

# Poly/ML 3.8 does not like libffi 3.3, so use the
# bundled libffi.
polyml_src_configure() {
	econf \
		--enable-shared \
		--disable-static \
		--without-system-libffi \
		$(use_with X x) \
		$(use_with gmp) \
		$(use_enable compact32bit) \
		$(use_enable native-codegeneration) \
		$(use_with threads)
}

polyml_src_compile() {
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

polyml_src_test() {
	emake tests || die "tests failed"
}
