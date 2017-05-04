# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# FIXME: Support for opengl USE-flag. But, for that, the OpenGL code
# in gtkada has to really work.

inherit multiprocessing pax-utils

DESCRIPTION="An Ada interface to GTK+"
HOMEPAGE="http://libre.adacore.com"

SRC_URI_PREFIX="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads"
SRC_URI="${SRC_URI_PREFIX}/${P}.tar.xz"

LICENSE="GPL-3+ gcc-runtime-library-exception-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
#IUSE="opengl" <-- I cannot get compilation with opengl to work (with Nvidia opengl).

RDEPEND="
	virtual/ada:*
	dev-libs/atk:*
	dev-libs/glib:*
	x11-libs/cairo:*
	x11-libs/pango:*
	>=x11-libs/gtk+-3.14.0:3
	doc? (
		>=virtual/gnatdoc-2016:*
		dev-python/sphinx:*[latex]
	)
"
#	opengl? ( virtual/opengl:* )
DEPEND="
	${RDEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900:*
"

RESTRICT="test"

QA_EXECSTACK="
	usr/*/gtkada/gtkada.static-pic/gtkada/libgtkada.a:gtkada-multi_paned.o
	usr/*/gtkada/gtkada.static-pic/gtkada/libgtkada.a:gtkada-mdi.o
	usr/*/gtkada/gtkada.static-pic/gtkada/libgtkada.a:gtkada-canvas_view.o
	usr/*/gtkada/gtkada.static-pic/gtkada/libgtkada.a:gtkada-canvas_view-views.o
	usr/*/gtkada/gtkada.static-pic/gtkada/libgtkada.a:gtkada-canvas_view-rtrees.o
	usr/*/gtkada/gtkada.static-pic/gtkada/libgtkada.a:gtkada-canvas_view-models-layers.o
	usr/*/gtkada/gtkada.static/gtkada/libgtkada.a:gtkada-multi_paned.o
	usr/*/gtkada/gtkada.static/gtkada/libgtkada.a:gtkada-mdi.o
	usr/*/gtkada/gtkada.static/gtkada/libgtkada.a:gtkada-canvas_view.o
	usr/*/gtkada/gtkada.static/gtkada/libgtkada.a:gtkada-canvas_view-views.o
	usr/*/gtkada/gtkada.static/gtkada/libgtkada.a:gtkada-canvas_view-rtrees.o
	usr/*/gtkada/gtkada.static/gtkada/libgtkada.a:gtkada-canvas_view-models-layers.o
	usr/*/gtkada/gtkada.relocatable/gtkada/libgtkada.so*
"

PATCHES=( "${FILESDIR}"/"${PF}".patch )

src_configure() {
	local with_gl="--with-GL=no"
#	use opengl && with_gl="--with-GL=auto"
	econf ${with_gl}
}

src_compile() {
	emake PROCESSORS="$(makeopts_jobs)" LIBDIR="$(get_libdir)"
	use doc && emake docs PROCESSORS="$(makeopts_jobs)" LIBDIR="$(get_libdir)"
}

src_install() {
	emake install PROCESSORS="$(makeopts_jobs)" prefix="${D}/usr" \
		  LIBDIR="$(get_libdir)"
	pax-mark m "${D}"/usr/"$(get_libdir)"/gtkada/gtkada.relocatable/gtkada/libgtkada.so*

	# FIXME: Repair the gtkada.gpr file. Is there some way to get it
	# written correctly in the first place? This way of building a
	# package is ridiculous.
	sed -i \
		-e 's|"-L[^"]*/usr/lib",|"-L/usr/'"$(get_libdir)"'",|g' \
		-e 's|"-L[^"]*/usr/bin",||g' \
		"${D}"/usr/share/gpr/"${PN}".gpr || die

	einstalldocs
	dodoc ANNOUNCE known-problems* features*
	use doc && {
		mv "${D}"/usr/share/doc/gtkada/* "${D}"/usr/share/doc/"${PF}"/. || die
		rmdir "${D}"/usr/share/doc/gtkada || die
	}
}
