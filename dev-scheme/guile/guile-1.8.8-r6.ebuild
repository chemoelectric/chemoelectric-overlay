# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
#inherit eutils autotools flag-o-matic elisp-common
inherit autotools flag-o-matic elisp-common

DESCRIPTION="Scheme interpreter"
HOMEPAGE="https://www.gnu.org/software/guile/"
SRC_URI="mirror://gnu/guile/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="debug debug-freelist debug-malloc +deprecated discouraged emacs +networking nls +readline +regex +threads"

#RESTRICT="!regex? ( test )"
RESTRICT="test"

DEPEND="
	!dev-scheme/guile:0
	!dev-scheme/guile:12
	!dev-scheme/guile:2
	app-eselect/eselect-guile:*
	>=dev-libs/gmp-4.1:*
	>=sys-devel/libtool-1.5.6:*
	sys-devel/gettext:*
	emacs? ( app-editors/emacs:* )
	readline? ( sys-libs/readline:* )
"
RDEPEND="${DEPEND}"

# We use our own slot system and block those of the "gentoo" and
# "lisp" repositories.
SLOT="1.8"
MAJOR="1.8"

src_prepare() {
	eapply "${FILESDIR}/${P}-fix_guile-config.patch"
	eapply "${FILESDIR}/${P}-fix_stack-grow-direction-check.patch"
	eapply "${FILESDIR}/${P}-config-with-readline.patch"
	eapply "${FILESDIR}/${P}-makeinfo-5.patch"
	eapply "${FILESDIR}/${P}-do-not-rm-build-guile.patch"
	eapply "${FILESDIR}/0001-Fix-configure.in-macro-for-automake-1.13.patch"
	eapply "${FILESDIR}/0002-Rename-guile-readline-configure-from-.in-to-.ac.patch"
	eapply_user
	eautoreconf
}

src_configure() {
	# see bug #178499
	filter-flags -ftree-vectorize

	#will fail for me if posix is disabled or without modules -- hkBst
	econf \
		--program-suffix="-${MAJOR}" \
		--infodir="${EPREFIX}"/usr/share/info/guile-${MAJOR} \
		--disable-error-on-warning \
		--disable-static \
		--enable-posix \
		$(use_enable networking) \
		$(use_enable regex) \
		$(use deprecated || use_enable discouraged) \
		$(use_enable deprecated) \
		$(use_enable emacs elisp) \
		$(use_enable nls) \
		--disable-rpath \
		$(use_enable debug-freelist) \
		$(use_enable debug-malloc) \
		$(use_enable debug guile-debug) \
		$(use_with threads) \
		$(use_with readline) \
		--with-modules \
		EMACS=no
}

src_compile()  {
	emake

	# Above we have disabled the build system's Emacs support;
	# for USE=emacs we compile (and install) the files manually
	if use emacs; then
		cd emacs
		elisp-compile *.el || die
	fi
}

src_install() {
	emake install DESTDIR="${ED}"

	# Maybe there is a proper way to do this? Symlink handled by eselect
	mv "${ED}"/usr/share/aclocal/guile.m4 "${ED}"/usr/share/aclocal/guile-${MAJOR}.m4 || die "rename of guile.m4 failed"

	dodoc AUTHORS ChangeLog GUILE-VERSION HACKING NEWS README THANKS

	# necessary for registering slib, see bug 206896
	keepdir /usr/share/guile/site

	if use emacs; then
		elisp-install ${PN} emacs/*.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/50${PN}-gentoo.el" || die
	fi
}

pkg_postinst() {
	[ "${EROOT}" == "/" ] && pkg_config
	use emacs && elisp-site-regen
	eselect guile update --if-unset
}

pkg_postrm() {
	use emacs && elisp-site-regen
	eselect guile update --if-unset
}

pkg_config() {
	if has_version dev-scheme/slib; then
		einfo "Registering slib with guile"
		install_slib_for_guile
	fi
}

_pkg_prerm() {
	rm -f "${EROOT}"/usr/share/guile/site/slibcat
}
