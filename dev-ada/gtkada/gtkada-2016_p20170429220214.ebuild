# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing

# FIXME: Support for opengl USE-flag. But, for that, the OpenGL code
# in gtkada has to really work.

# FIXME: Make a patch to gtkada-2016, rather than take a snapshot of
# the Git repository.

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

src_prepare() {
	eapply "${FILESDIR}/${PVR}"
	eapply_user
}

src_configure() {
	local with_gl="--with-GL=no"
#	use opengl && with_gl="--with-GL=auto"
	econf ${with_gl}
}

src_compile() {
	emake -j1 PROCESSORS="$(makeopts_jobs)"
	use doc && emake -j1 docs PROCESSORS="$(makeopts_jobs)"
}

src_install() {
	emake -j1 install PROCESSORS="$(makeopts_jobs)" prefix="${D}/usr"
	einstalldocs
	use doc && {
		mv "${D}"/usr/share/doc/gtkada/* "${D}"/usr/share/doc/"${PF}"/. || die
		rmdir "${D}"/usr/share/doc/gtkada || die
	}
}
