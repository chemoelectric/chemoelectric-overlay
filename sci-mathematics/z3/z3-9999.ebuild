# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit flag-o-matic git-r3 python-r1 toolchain-funcs

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

pkg_setup() {
	if [[ "${MERGE_TYPE}" != binary ]]; then
		if [[ $(tc-getCXX)$ == *g++* ]] && ! tc-has-openmp; then
			ewarn "Please use an openmp compatible compiler"
			ewarn "like >gcc-4.2 with USE=openmp"
			die "Openmp support missing in compiler"
		fi
	fi
}

src_configure() {
	append-cxxflags -fopenmp
	append-ldflags -fopenmp
	python_export_best
	${EPYTHON} scripts/mk_make.py --prefix=/usr || die
}

src_compile() {
	emake --directory="build" \
		  CXX="$(tc-getCXX)" \
		  LINK="$(tc-getCXX) ${LDFLAGS}" \
		  LINK_FLAGS="${LDFLAGS}"
}

src_install() {
	emake --directory="build" install DESTDIR="${ED}"
}
