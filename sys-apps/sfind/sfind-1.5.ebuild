# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

SCHILY_N=schily
SCHILY_V=2012-06-10
SCHILY_NV=${SCHILY_N}-${SCHILY_V}

DESCRIPTION="Schily's find"
HOMEPAGE="ftp://ftp.berlios.de/pub/${SCHILY_N}/"
SRC_URI="ftp://ftp.berlios.de/pub/${SCHILY_N}/${SCHILY_NV}.tar.bz2"
LICENSE="CDDL-Schily"

SLOT="0"
KEYWORDS="~amd64"

IUSE=""

# Use cdrtools to get libschily. (!) I do not know if cdrkit will work
# as a substitute for cdrtools. There ought to be a separate ebuild
# for libschily.
RDEPEND=">=app-cdr/cdrtools-3.00"
DEPEND="
    ${RDEPEND}
    >=sys-devel/smake-1.2_alpha49
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
	pushd "${instdir}"
	dobin bin/*
	doman share/man/*/*.[0-9]*
	popd
}
