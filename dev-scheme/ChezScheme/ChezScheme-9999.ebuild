# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 multilib

DESCRIPTION="Chez Scheme: a superset of R6RS Scheme"
HOMEPAGE="https://cisco.github.io/${PN}/"
EGIT_REPO_URI="https://github.com/cisco/${PN}.git"
LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS=""

IUSE="threads X"

# libX11.so is dlopened if needed, and I do not believe the header
# files are used. Therefore I have included it only in runtime
# dependencies.
DEPEND="
	sys-libs/ncurses:*
"
RDEPEND="
	${DEPEND}
	X? ( x11-libs/libX11:* )
"

src_configure() {
	local flags=""
	flags+=" --installprefix=${EPREFIX}/usr"
	flags+=" --installbin=${EPREFIX}/usr/bin"
	flags+=" --installlib=${EPREFIX}/usr/$(get_libdir)"
	flags+=" --installman=${EPREFIX}/usr/share/man"
	flags+=" --temproot=${ED}"
	flags+=" --nogzip-man-pages"
	use threads && flags+=" --threads"
	use X || flags+=" --disable-x11"

	einfo "Flags to be passed to configure:"
	einfo "  ${flags}"

	# The configure script is not one created by Autoconf,
	# so run it directly.
	./configure ${flags}
}

src_install() {
	# Install the examples in /usr/share/doc instead of in
	# /usr/$(get_libdir)
	emake install \
		  InstallLibExamples="${EPREFIX}/usr/share/doc/${PF}/examples"

	dodoc CHARTER* README* LOG* NOTICE*
}
