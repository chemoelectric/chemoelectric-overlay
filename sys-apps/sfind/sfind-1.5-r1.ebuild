# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

SCHILY_N=schily
SCHILY_V=2014-06-12
SCHILY_NV=${SCHILY_N}-${SCHILY_V}

DESCRIPTION="Schily's find"
HOMEPAGE="https://sourceforge.net/projects/schilytools/"
SRC_URI="mirror://sourceforge/schilytools/${SCHILY_NV}.tar.bz2"
LICENSE="CDDL-Schily"

SLOT="0"
KEYWORDS="~amd64"

IUSE=""

# Use cdrtools to get libschily. (!) I do not know if cdrkit will work
# as a substitute for cdrtools. There ought to be a separate ebuild
# for libschily.
RDEPEND=">=app-cdr/cdrtools-3.01_alpha17"
DEPEND="
	${RDEPEND}
	>=sys-devel/smake-1.2.4
"

S="${WORKDIR}/${SCHILY_NV}/sfind"

src_configure() {
	:
}

src_compile() {
	smake || die "smake failed"
}

src_install() {
	local instdir="${WORKDIR}/inst"

	smake INS_BASE="${instdir}" install || die "smake INS_BASE=\"${instdir}\" install failed"
	(
		cd "${instdir}"
		dobin bin/*
		doman share/man/*/*.[0-9]*
	)
}
