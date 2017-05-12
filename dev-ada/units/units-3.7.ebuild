# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing

DESCRIPTION="Units of measurement for Ada"
HOMEPAGE="https://sourceforge.net/projects/unitsofmeasurementforada/"
SRC_URI="mirror://sourceforge/unitsofmeasurementforada/${PN}_${PV/./_}.tgz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="virtual/ada:*"
DEPEND="
	${RDEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900
"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )

# Let us make the soname a simple mathematical function of the package
# version. Can someone come up with a better soname, given that we
# have little control over library version compatibility?
MAJOR_VERSION="${PV/.*/}"
MINOR_VERSION="${PV/*./}"
SO_VERSION="$(( 1000 * ${MAJOR_VERSION} + ${MINOR_VERSION} ))"
LIB_NAME="${PN}"
SO_EXTENSION=".so.${SO_VERSION}"

library_types() {
	echo "static static-pic relocatable"
}

src_unpack() {
	cd "${WORKDIR}"
	mkdir "${P}" || die
	cd "${P}" || die
	unpack "${P}.tar.gz"
}

src_prepare() {
	default
	rm strings_edit* tables* || die
}

src_configure() {
	sed -e 's|@LIB_NAME@|'"${LIB_NAME}"'|g' \
		-e 's|@SO_EXTENSION@|'"${SO_EXTENSION}"'|g' \
		-i "${PN}.gpr" || die
}

src_compile() {
	for lt in $(library_types) ; do
		export LIBRARY_TYPE="${lt}"
		export STRINGS_EDIT_BUILD="${lt}"
		export TABLES_BUILD="${lt}"
		${GPRBUILD:-gprbuild} -j"$(makeopts_jobs)" -v -p -R -P"${PN}" || die
	done
}

src_install() {
	for lt in $(library_types) ; do
		export LIBRARY_TYPE="${lt}"
		export STRINGS_EDIT_BUILD="${lt}"
		export TABLES_BUILD="${lt}"
		${GPRINSTALL:-gprinstall} \
			-v -p -f -P"${PN}" \
			--prefix="${D}/usr" \
			--link-lib-subdir="$(get_libdir)" \
			--install-name="${PN}" \
			--build-name="${lt}" \
			--lib-subdir="$(get_libdir)/${PN}/${PN}.${lt}" \
			--sources-subdir="include/${PN}/${PN}.${lt}" || die
	done
	einstalldocs
	dodoc "readme_${PN}.txt"
	use doc && {
		docinto html
		dodoc "${PN}.htm" *.jpg *.gif
		docinto ..
	}
}
