# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

###
### FIXME: This package installs stuff in /usr/lib that ought to go
### elsewhere.
###
### FIXME: This package ignores CFLAGS and who knows what else.
###

DESCRIPTION="ATS2 Programming Language"
HOMEPAGE="http://www.ats-lang.org"
SRC_URI_PREFIX="mirror://sourceforge/ats2-lang/ats2-lang/${PN}-postiats-${PV}/ATS2-Postiats-"
SRC_URI="
	${SRC_URI_PREFIX}${PV}.tgz
	contrib? ( ${SRC_URI_PREFIX}include-${PV}.tgz )
"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="+contrib"

# FIXME: The dependence on dev-libs/gmp will go away in future
# versions of ATS2.
RDEPEND="dev-libs/gmp"

# FIXME: Are there any interesting build dependencies? And will we
# need pkg-config at all, once dev-libs/gmp is not needed?
DEPEND="
	${RDEPEND}
	app-arch/tar
	virtual/pkgconfig
"

S="${WORKDIR}/ATS2-Postiats-${PV}"

src_compile() {
	emake -j1 all
}

src_install() {
	local patshome="/usr/lib/${PN}-postiats-${PV}"

	default

	use contrib && \
		(tar -C "${WORKDIR}/ATS2-Postiats-include-${PV}" -c -f - . \
		| tar -C "${D}${patshome}" -x -f -) \
		|| die "failure while trying to copy ATS2-include into place"

	{
		echo "PATSHOME=${patshome}"
		use contrib && echo "PATSHOMERELOC=${patshome}"
	} >> "${T}/50ats2" || die "failed to make 50ats2"
	doenvd "${T}/50ats2"
}
