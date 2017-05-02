# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing

DESCRIPTION="XML parser for Ada95"
HOMEPAGE="http://libre.adacore.com"
SRC_URI_PREFIX="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads"
SRC_URI="${SRC_URI_PREFIX}/${P}.tar.xz"

LICENSE="GPL-3+ gcc-runtime-library-exception-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="virtual/ada:*"
DEPEND="
	${RDEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900:*
	doc? ( dev-python/sphinx:*[latex] )
"

# FIXME: Implement tests.
RESTRICT="test"

HTML_DOCS=""

PATCHES=( "${FILESDIR}/gentoo-${PV}.patch" )

src_compile() {
	# The -R option turns off RUNPATH support. We put a link to the
	# library in the ld.so search path, instead.
	#
	# FIXME: Find a way to get gprbuild to insert correct RUNPATHs.
	#
	emake PROCESSORS="$(makeopts_jobs)" \
		  GPRBUILD="${GPRBUILD:-gprbuild} -v -R"
	use doc && emake -e -C docs html latexpdf
}

src_install() {
	emake install prefix="${D}/usr" LIBDIR="$(get_libdir)" \
		  PROCESSORS="$(makeopts_jobs)" \
		  GPRINSTALL="${GPRINSTALL:-gprinstall} -v"

	einstalldocs
	use doc && {
		rm "${D}/usr/share/doc/${PN}/.buildinfo" || :
		dodir "/usr/share/doc/${PF}"
		mv "${D}/usr/share/doc/${PN}/"*.pdf "${D}/usr/share/doc/${PF}/" || die
		mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}/html" || die
	}
}
