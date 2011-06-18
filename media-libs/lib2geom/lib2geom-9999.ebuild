# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"
ESVN_REPO_URI="http://${PN}.svn.sourceforge.net/svnroot/${PN}/${PN}/trunk"

inherit cmake-utils subversion eutils

# For now, hardcode the Python ABI. (FIXME)
PYTHON_ABI=2.7

DESCRIPTION="A computational geometry library"
HOMEPAGE="http://2geom.org/"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python"

RDEPEND="
   x11-libs/gtk+:2
   dev-cpp/gtkmm:2.4
   >=x11-libs/cairo-1.10.2-r1
   >=dev-cpp/cairomm-1.9.8
   >=dev-libs/boost-1.46.1
   >=sci-libs/gsl-1.15
   python? ( =dev-lang/python-${PYTHON_ABI}* )
"
DEPEND="${RDEPEND}"

src_prepare() {
	cd ${S}
    sed -i -e '
      s|${PYTHON_LIB_INSTALL}/\.\./dist-packages|/usr/'"$(get_libdir)"'/python'"${PYTHON_ABI}"'/site-packages|
      ' src/2geom/py2geom/CMakeLists.txt || die "sed of CMakeLists.txt failed"
}

src_configure() {
	local mycmakeargs="
        -D2GEOM_BUILD_SHARED:BOOL=ON
        -D2GEOM_LPE_TOYS:BOOL=OFF
        -D2GEOM_TOYS:BOOL=OFF
        "
    use python && mycmakeargs+=" -D2GEOM_BOOST_PYTHON:BOOL=ON "
    use python || mycmakeargs+=" -D2GEOM_BOOST_PYTHON:BOOL=OFF "

    cmake-utils_src_configure
}

src_compile() {
	cd "${CMAKE_BUILD_DIR}"
	emake
	use python && emake py2geom
}

src_install() {
    local config_h

    # Sanitize headers by removing includes of config.h.
	sed -i -e '/#include "config\.h"/d' src/2geom/*.h || die "sed of headers failed"

    cmake-utils_src_install

    (cd doc && (make manual.pdf || "make manual.pdf failed"))
    dodoc -r doc
    (cd src/2geom && dodoc -r toys)
}
