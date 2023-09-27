# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

###
### FIXME: This package installs stuff in /usr/lib that ought to go
### elsewhere.
###
### FIXME: This package ignores CFLAGS and who knows what else.
###

DESCRIPTION="ATS1 Programming Language"
HOMEPAGE="http://www.ats-lang.org"
SRC_URI="mirror://sourceforge/ats-lang/ats-lang/anairiats-${PV}/${PN}-lang-anairiats-${PV}.tgz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/glib:=
	x11-libs/gtk+:2
	sys-libs/ncurses:=
	dev-libs/gmp:=
	dev-libs/libpcre
	virtual/opengl
	media-libs/libsdl
	dev-libs/boehm-gc
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	"

S="${WORKDIR}"/ats-lang-anairiats-${PV}

src_compile() {
	emake -j1
}

src_install() {
	default

	# The default installation leaves out some stuff.
	# Install the stuff by brute force.
	insinto "/usr/lib/ats-anairiats-${PV}"
	doins -r ccomp/runtime contrib doc libats libatsdoc libc prelude utils

	( echo "ATSHOME=/usr/lib/ats-anairiats-${PV}"
	  echo "ATSHOMERELOC=ATS-${PV}"	) > "${T}/50ats-anairiats" ||
		die "failed to make 50ats-anairiats"
	doenvd "${T}/50ats-anairiats"
}
