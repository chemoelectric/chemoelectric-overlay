# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing

DESCRIPTION="Posix bindings for Ada"
HOMEPAGE="http://libre.adacore.com/"
SRC_URI="http://mirrors.cdn.adacore.com/art/57399229c7a447658e0aff79 -> florist-gpl-2016-src.tar.gz"

LICENSE="GPL-2+ GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="threads"

RDEPEND="virtual/ada:*"
DEPEND="${RDEPEND} dev-ada/gprbuild:*"

S="${WORKDIR}/${PN}-gpl-${PV}-src"

# FIXME: Make this install more than just the shared library, but also
# static and static-pic, with respective subdirectories. And try to
# position the library in the filesystem hierarchy at a level lower
# down than /usr.

PATCHES=( "${FILESDIR}/${PVR}" )

src_configure() {
	if use threads ; then
		econf --enable-shared
	else
		econf --enable-shared --disable-threads
	fi
}

src_compile() {
	emake PROCESSORS="$(makeopts_jobs)"
}

src_install() {
	emake install PREFIX="${D}/usr" PROCESSORS="$(makeopts_jobs)"
	dodir /usr/"$(get_libdir)"
	ln -s -r \
	   $(find "${D}" -name 'libflorist.so*' -print) \
	   "${D}"/usr/"$(get_libdir)" || die
	einstalldocs
}
