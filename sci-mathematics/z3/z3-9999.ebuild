# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit multilib flag-o-matic git-r3 python-single-r1 toolchain-funcs

DESCRIPTION="An efficient theorem prover"
HOMEPAGE="https://github.com/Z3Prover/z3/wiki"
SRC_URI=""
EGIT_REPO_URI="https://github.com/Z3Prover/z3.git"
EGIT_MIN_CLONE_TYPE=single

SLOT="0"
LICENSE="MIT"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
DEPEND="
	${RDEPEND}
	dev-libs/gmp:0
	net-misc/curl
"

MY_SONAME="lib${PN}.so.0.1"

pkg_setup() {
	if [[ "${MERGE_TYPE}" != binary ]]; then
		if [[ $(tc-getCXX)$ == *g++* ]] && ! tc-has-openmp; then
			ewarn "Please use an openmp compatible compiler"
			ewarn "like >gcc-4.2 with USE=openmp"
			die "Openmp support missing in compiler"
		fi
	fi
	python-single-r1_pkg_setup
	append-cxxflags -fopenmp
	append-ldflags -fopenmp
}

src_configure() {
	${EPYTHON} scripts/mk_make.py --prefix=/usr || die
	sed -i -e "s|(PREFIX)/lib|(PREFIX)/$(get_libdir)|g" build/Makefile
}

src_compile() {
	emake --directory="build" \
		  CXX="$(tc-getCXX)" \
		  LINK="$(tc-getCXX)" \
		  LINK_FLAGS="${LDFLAGS}" \
		  SLINK_FLAGS="-shared -Wl,-soname,${MY_SONAME} ${LDFLAGS}"
}

src_install() {
	emake --directory="build" install DESTDIR="${ED}"
	dosym libz3.so "/usr/$(get_libdir)/${MY_SONAME}"
	dodoc README RELEASE_NOTES
}
