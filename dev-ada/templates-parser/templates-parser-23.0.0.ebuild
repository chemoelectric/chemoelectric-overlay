# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ADA_COMPAT=( gnat_2021 gcc_12{,_2_0} )

inherit ada multiprocessing

DESCRIPTION="AWS templates engine"
HOMEPAGE="https://www.adacore.com"
SRC_URI="
	https://github.com/AdaCore/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+shared static-libs static-pic"

RESTRICT="test"

REQUIRED_USE="
	|| ( shared static-libs static-pic )
	${ADA_REQUIRED_USE}
"

RDEPEND="
	${ADA_DEPS}
	dev-ada/xmlada:=[${ADA_USEDEP},static-libs?,static-pic?]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-ada/gprbuild[${ADA_USEDEP}]"

# FIXME: This ebuild does not build the docs.

src_prepare() {
	default
	cp config/tp_xmlada_installed.gpr tp_xmlada.gpr || die
}

src_compile() {
	build () {
		gprbuild -v -k -XTP_XMLADA=Installed \
				 -XLIBRARY_TYPE=$1 -XXMLADA_BUILD=$1 -XBUILD_MODE=prod \
				 -P templates_parser.gpr -p -j$(makeopts_jobs) \
				 -cargs:Ada ${ADAFLAGS} || die
		gprbuild -v -k -XTP_XMLADA=Installed \
				 -XLIBRARY_TYPE=$1 -XXMLADA_BUILD=$1 -XBUILD_MODE=prod \
				 -P tools/tools.gpr -p -j$(makeopts_jobs) \
				 -cargs:Ada ${ADAFLAGS} || die
	}
	if use shared; then
		build relocatable
	fi
	if use static-libs; then
		build static
	fi
	if use static-pic; then
		build static-pic
	fi
}

src_install() {
	build () {
		gprinstall -XTP_XMLADA=Installed -XLIBRARY_TYPE=$1 -XBUILD_MODE=prod \
				   --prefix="${D}"/usr --sources-subdir=include/templates_parser \
				   --build-name=$1 --build-var=LIBRARY_TYPE \
				   --build-var=TEMPLATES_PARSER_BUILD \
				   -P templates_parser.gpr -p -f || die
		gprinstall -XTP_XMLADA=Installed -XLIBRARY_TYPE=$1 -XBUILD_MODE=prod \
				   --prefix="${D}"/usr --sources-subdir=include/templates_parser \
				   --build-name=$1 --build-var=LIBRARY_TYPE \
				   --build-var=TEMPLATES_PARSER_BUILD \
				   -P tools/tools.gpr -p -f || die
	}
	if use shared; then
		build relocatable
	fi
	if use static-libs; then
		build static
	fi
	if use static-pic; then
		build static-pic
	fi
	einstalldocs
}
