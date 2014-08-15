# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib libtool

DESCRIPTION="Posix bindings for Ada"
HOMEPAGE="http://libre.adacore.com/"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-devel/gcc[ada]"
RDEPEND="${DEPEND}"

src_prepare() {
	elibtoolize

	# We are moving /prefix/forestlib to (for instance)
	# /usr/lib64/forest.
	sed -i \
		-e "s|../../floristlib|../../$(get_libdir)/florist|g" \
		${PN}.gpr || die
	sed -i \
		-e "s|/prefix/floristlib|/usr/$(get_libdir)/florist|g" \
		-e "s|prefix/lib/gnat|/usr/$(get_libdir)/gnat|g" \
		README || die

	# The default gnatmake flags do not include the user's settings,
	# and also cause the build to fail, because -gnatg implicitly sets
	# -gnatwe (a setting we counteract by adding -gnatwn).
	sed -i \
		-e "s|^GNATMAKEFLAGS1B[ 	]*=[ 	]*.*|GNATMAKEFLAGS1B = ${GNATMAKEFLAGS} -gnatpg -gnatwn|" \
		Makefile.in || die
}

src_compile() {
	emake
	emake floristlib
}

src_install() {
	dodoc README

	dodir /usr/include/"${PN}"
	insinto /usr/include/"${PN}"
	doins -r *.ad{b,s} *.c *.gpb gnatsocks/

	local inst_floristlib=/usr/"$(get_libdir)"/"${PN}"
	dodir "${inst_floristlib}"
	cp -R -p floristlib/{libflorist.a,*.ali} "${D}${inst_floristlib}" \
		|| die
	chmod 0444 "${D}${inst_floristlib}"/*.ali || die

	dodir /usr/"$(get_libdir)"/gnat
	insinto /usr/"$(get_libdir)"/gnat
	doins florist.gpr
}
