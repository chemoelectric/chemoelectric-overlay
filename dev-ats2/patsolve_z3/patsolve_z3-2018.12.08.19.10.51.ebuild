# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Use Z3 Prover as an external constraint solver for ATS2/Postiats"
HOMEPAGE="http://www.ats-lang.org/"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/ATS-Postiats-snapshot-${PV}.tar.gz"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/gmp:0
	dev-libs/json-c:0
"
RDEPEND="
	${DEPEND}
	sci-mathematics/z3
"

S="${WORKDIR}/ATS-Postiats-snapshot-${PV}"

src_prepare() {
	eapply "${FILESDIR}/usr-include-z3.patch"
	default
}

src_compile() {
	export PATSHOME="${S}"

	# Build the ATS2 compiler (but not to install it).
	emake -j1 CCOMP="$(tc-getCC)"

	# Use the ATS2 compiler, just built, to compile patsolve_z3.
	emake -j1 -C contrib/ATS-extsolve-z3 CCOMP="$(tc-getCC)"
}

src_install() {
	dobin contrib/ATS-extsolve-z3/bin/patsolve_z3
}
