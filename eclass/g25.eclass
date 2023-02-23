# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

case "${EAPI:-0}" in
	0|1|2|3|4|5|6) die "EAPI=${EAPI} is not supported" ;;
esac

live_build() {
	ver_test 2.5.99999999 -le ${PV}
}

if live_build; then
	inherit mercurial
	inherit autotools
fi

DESCRIPTION="Gaigen 2.5: Geometric Algebra Implementation Generator"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/g25/"
if live_build; then
	EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/g25"
else
	SRC_URI="https://sourceforge.net/projects/chemoelectric/files/Crud-Factory-Gaigen-2.5/${P}.tar.gz"
fi
LICENSE="GPL-3+ LGPL-2.1+ BSD"

IUSE="test"

RDEPEND="
	>=dev-lang/mono-6.10.0.104:=
"
DEPEND="
	${RDEPEND}
	test? (
		  >=sys-devel/autoconf-2.69:*
		  dev-java/antlr:3
		  virtual/jre
		  virtual/jdk
		  app-alternatives/awk
	)
"
BDEPEND="
	${RDEPEND}
	>=app-text/texlive-core-2020-r12:*
	>=dev-texlive/texlive-basic-2020-r1:*
	>=dev-texlive/texlive-latex-2020:*
	>=dev-texlive/texlive-latexextra-2020-r2:*
"

EXPORT_FUNCTIONS \
	pkg_setup \
	src_unpack \
	src_prepare \
	src_configure \
	src_test

g25_pkg_setup() {
	if use test; then
		elog
		elog "You can set use the environment variable TESTSUITEFLAGS"
		elog "to tailor the tests or run them in parallel. See"
		elog "https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.70/autoconf.html#testsuite-Invocation"
		elog "for a description of flags."
		elog
	fi
}

g25_src_unpack() {
	default

	if live_build; then
		mercurial_src_unpack
	fi

	local dotlocal_share_cogsharp="${S}/tests/dotlocal-share-cogsharp/dotlocal-share-cogsharp-2021.03.25.10.26.46.tar.gz"
	if use test && [[ -f "${dotlocal_share_cogsharp}" ]]; then
		pushd "${HOME}" > /dev/null || die
		unpack "${dotlocal_share_cogsharp}"
		popd > /dev/null || die
	fi
}

g25_src_prepare() {
	default
	if live_build; then
		eautoreconf
	fi
}

g25_src_configure() {
	if [[ -z "${CSCFLAGS}" ]]; then
		CSCFLAGS='-nologo -optimize+ -debug- -define:TRACE'
	fi
	econf CSC=/usr/bin/csc \
		  CSCFLAGS="${CSCFLAGS}" \
		  MONO=/usr/bin/mono \
		  MCS=/usr/bin/mcs
}

g25_src_test() {
	# FIXME: The tests seem to use ‘gcc’ and ‘g++’, rather than the
	#        platform-specific compiler commands. One may wish to fix
	#        that.
	emake check CFLAGS= CXXFLAGS= TESTSUITEFLAGS="${TESTSUITEFLAGS}"
}
