# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xterm/xterm-297.ebuild,v 1.7 2013/10/05 18:10:03 maekke Exp $

EAPI=5

inherit eutils flag-o-matic multilib

DESCRIPTION="Terminal Emulator for X Windows"
HOMEPAGE="http://invisible-island.net/xterm/"
SRC_URI="ftp://invisible-island.net/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+openpty toolbar truetype unicode Xaw3d"

COMMON_DEPEND="kernel_linux? ( sys-libs/libutempter )
	kernel_FreeBSD? ( || ( >=sys-freebsd/freebsd-lib-9.0 sys-libs/libutempter ) )
	>=sys-libs/ncurses-5.7-r7
	x11-apps/xmessage
	x11-libs/libX11
	x11-libs/libXaw
	x11-libs/libXft
	x11-libs/libxkbfile
	x11-libs/libXmu
	x11-libs/libXrender
	x11-libs/libXt
	unicode? ( x11-apps/luit )
	Xaw3d? ( x11-libs/libXaw3d )"
RDEPEND="${COMMON_DEPEND}
	media-fonts/font-misc-misc"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	x11-proto/kbproto
	x11-proto/xproto"

DOCS=( README{,.i18n} ctlseqs.txt )

pkg_setup() {
	DEFAULTS_DIR="${EPREFIX}"/usr/share/X11/app-defaults
}

src_configure() {
	# 454736
	# Workaround for ncurses[tinfo] until upstream fixes their buildsystem using
	# something sane like pkg-config or ncurses5-config and stops guessing libs
	# Everything gets linked against ncurses anyways, so don't shout
	append-ldflags $(pkg-config --libs ncurses)

	econf \
		--libdir="${EPREFIX}"/etc \
		--disable-full-tgetent \
		--with-app-defaults="${DEFAULTS_DIR}" \
		--disable-setuid \
		--disable-setgid \
		--with-utempter \
		--with-x \
		$(use_with Xaw3d) \
		--disable-imake \
		--enable-256-color \
		--enable-broken-osc \
		--enable-broken-st \
		--enable-exec-xterm \
		$(use_enable truetype freetype) \
		--enable-i18n \
		--enable-load-vt-fonts \
		--enable-logging \
		$(use_enable openpty) \
		$(use_enable toolbar) \
		$(use_enable unicode mini-luit) \
		$(use_enable unicode luit) \
		--enable-wide-chars \
		--enable-dabbrev \
		--enable-warnings
}

src_install() {
	default

	dohtml xterm.log.html
	domenu *.desktop

	# Fix permissions -- it grabs them from live system, and they can
	# be suid or sgid like they were in pre-unix98 pty or pre-utempter days,
	# respectively (#69510).
	# (info from Thomas Dickey) - Donnie Berkholz <spyderous@gentoo.org>
	fperms 0755 /usr/bin/xterm

	# restore the navy blue
	sed -i -e "s:blue2$:blue:" "${D}${DEFAULTS_DIR}"/XTerm-color || die
}