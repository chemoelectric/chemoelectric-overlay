# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing

DESCRIPTION="An Ada library for tables indexed by strings"
HOMEPAGE="https://sourceforge.net/projects/tablesforada/"
SRC_URI="mirror://sourceforge/tablesforada/${PN}_${PV/./_}.tgz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

COMMON_DEPEND="virtual/ada:*"
DEPEND="
	${COMMON_DEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900
"
RDEPEND="
	${COMMON_DEPEND}
"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )

DOCS="*.txt"
HTML_DOCS="*.htm *.jpg *.gif"

LIBRARY_TYPES="static static-pic relocatable"

# Let us make the soname a simple mathematical function of the package
# version. Can someone come up with a better soname, given that we
# have little control over library version compatibility?
MAJOR_VERSION="${PV/.*/}"
MINOR_VERSION="${PV/*./}"
SO_VERSION="$(( 1000 * ${MAJOR_VERSION} + ${MINOR_VERSION} ))"
LIB_NAME="${PN}"
SO_NAME="lib${LIB_NAME}.so.${SO_VERSION}"

src_unpack() {
	cd "${WORKDIR}"
	mkdir "${P}" || die
	cd "${P}" || die
	unpack "${P}.tar.gz"
}

src_prepare() {
	default
	sed -i \
		-e 's|@LIB_NAME@|'"${LIB_NAME}"'|g' "${PN}.gpr" \
		-e 's|@SO_NAME@|'"${SO_NAME}"'|g' "${PN}.gpr" \
		|| die
	mv test_tables examples || die
}

src_compile() {
	local gprbuild="${GPRBUILD:-gprbuild} -j$(makeopts_jobs) -v -p -R -P${PN}"
	for lt in ${LIBRARY_TYPES} ; do
		${gprbuild} -XLIBRARY_TYPE="${lt}" || die
	done
}

src_install() {
	local gprinstall="${GPRINSTALL:-gprinstall} -v -p -f -P${PN} \
		  --prefix=${D}/usr --link-lib-subdir=$(get_libdir) \
		  --install-name=${PN}"
	for lt in ${LIBRARY_TYPES} ; do
		${gprinstall} -XLIBRARY_TYPE="${lt}" \
					  --build-name="${lt}" \
					  --lib-subdir="$(get_libdir)/${PN}/${PN}.${lt}" \
					  --sources-subdir="include/${PN}/${PN}.${lt}"
	done
	einstalldocs
	use examples && dodoc -r examples
}
