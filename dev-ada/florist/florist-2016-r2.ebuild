# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# FIXME: Support multilib. The main difficulty probably would be that
# you need different GPR_PROJECT_PATH for the different ABIs, or else
# an `ABI' variable that is used by the gpr file...
# On further examination, I think it might be necessary to treat this
# as "cross-compilation" in gprbuild, with a new set of configurations.

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

PATCHES=( "${FILESDIR}/${PVR}" )

src_configure() {
	if use threads ; then
		econf
	else
		econf --disable-threads
	fi
}

src_compile() {
	emake PROCESSORS="$(makeopts_jobs)" LIBDIR="$(get_libdir)"
}

src_install() {
	emake install PREFIX="${D}/usr" \
		  PROCESSORS="$(makeopts_jobs)" \
		  LIBDIR="$(get_libdir)"
	einstalldocs
}
