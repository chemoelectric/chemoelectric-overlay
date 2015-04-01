# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
AUTOTOOLS_AUTORECONF=yes

EGIT_REPO_URI="https://chemoelectric@bitbucket.org/chemoelectric/${PN}.git"

inherit readme.gentoo autotools-multilib eutils libtool toolchain-funcs flag-o-matic git-2

DESCRIPTION="Crud Factory fontconfig: a fork of fontconfig"
HOMEPAGE="https://bitbucket.org/chemoelectric/fontconfig"
SRC_URI=""

LICENSE="MIT"
SLOT="1.0"
KEYWORDS=""
IUSE="doc static-libs"

RESTRICT="test"

RDEPEND="
	>=media-libs/freetype-2.2.1[${MULTILIB_USEDEP}]
	>=dev-libs/expat-1.95.3[${MULTILIB_USEDEP}]
	abi_x86_32? ( !app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)] )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	doc? (
		app-text/docbook-sgml-utils[jadetex]
		=app-text/docbook-sgml-dtd-3.1*
	)
"
PDEPEND="
	!x86-winnt? ( app-eselect/eselect-fontconfig )
	virtual/ttf-fonts
"

MULTILIB_CHOST_TOOLS=(
	   /usr/bin/fc-cache
)

pkg_setup() {
	DOC_CONTENTS="Please make fontconfig configuration changes using
	   \`eselect fontconfig\`. Any changes made to /etc/fonts/fonts.conf will be
	   overwritten. If you need to reset your configuration to upstream defaults,
	   delete the directory ""${EROOT}""etc/fonts/conf.d/ and re-emerge fontconfig."
}

src_prepare() {
	/bin/sh autogen.sh --noconf || die "autogen.sh failed"

	epatch "${FILESDIR}"/${PN}-2.7.1-latin-reorder.patch	# 130466
	epatch "${FILESDIR}"/${PN}-2.3.2-docbook.patch			# 310157
	epatch "${FILESDIR}"/${PN}-2.8.0-urw-aliases.patch		# 303591

	mkdir -p m4
	eautoreconf --install

	# Needed to get a sane .so versioning on fbsd, please dont drop
	# If you have to run eautoreconf, you can also leave the elibtoolize call as
	# it will be a no-op.
	elibtoolize
}

src_configure() {
	local addfonts
	# harvest some font locations, such that users can benefit from the
	# host OS's installed fonts
	case ${CHOST} in
	    *-darwin*)
	        addfonts=",/Library/Fonts,/System/Library/Fonts"
	        ;;
	    *-solaris*)
	        [[ -d /usr/X/lib/X11/fonts/TrueType ]] && \
	            addfonts=",/usr/X/lib/X11/fonts/TrueType"
	        [[ -d /usr/X/lib/X11/fonts/Type1 ]] && \
	            addfonts="${addfonts},/usr/X/lib/X11/fonts/Type1"
	        ;;
	    *-linux-gnu)
	        use prefix && [[ -d /usr/share/fonts ]] && \
	            addfonts=",/usr/share/fonts"
	        ;;
	esac

	local myeconfargs=(
		#$(use_enable doc docbook)
		# always enable docs to install manpages
		#--enable-docs
		--localstatedir="${EPREFIX}"/var
		--with-default-fonts="${EPREFIX}"/usr/share/fonts
		--with-add-fonts="${EPREFIX}/usr/local/share/fonts${addfonts}"
		--with-templatedir="${EPREFIX}"/etc/fonts/conf.avail
	)

	autotools-multilib_src_configure
}

multilib_src_install() {
	#	autotools-multilib_src_install
	default

	# XXX: avoid calling this multiple times, bug #459210
	if multilib_is_native_abi; then
		# stuff installed from build-dir
		#emake -C doc DESTDIR="${D}" install-man          <-- manpages currently are not supported.

		insinto /etc/fonts
		doins fonts.conf
	fi
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files --all

	#fc-lang directory contains language coverage datafiles
	#which are needed to test the coverage of fonts.
	insinto /usr/share/fc-lang
	doins fc-lang/*.orth

	[[ -e doc/fontconfig-user.txt ]] && dodoc doc/fontconfig-user.txt
	[[ -e doc/fontconfig-user.pdf ]] && dodoc doc/fontconfig-user.pdf

	if [[ -e ${ED}usr/share/doc/fontconfig/ ]];  then
		mv "${ED}"usr/share/doc/fontconfig/* "${ED}"/usr/share/doc/${P} || die
		rm -rf "${ED}"usr/share/doc/fontconfig
	fi

	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf we force update it ...
	echo 'CONFIG_PROTECT_MASK="/etc/fonts/fonts.conf"' > "${T}"/37fontconfig
	doenvd "${T}"/37fontconfig

	# As of fontconfig 2.7, everything sticks their noses in here.
	dodir /etc/sandbox.d
	echo 'SANDBOX_PREDICT="/var/cache/fontconfig"' > "${ED}"/etc/sandbox.d/37fontconfig

	readme.gentoo_create_doc
}

pkg_preinst() {
	# Bug #193476
	# /etc/fonts/conf.d/ contains symlinks to ../conf.avail/ to include various
	# config files.  If we install as-is, we'll blow away user settings.
	ebegin "Syncing fontconfig configuration to system"
	if [[ -e ${EROOT}/etc/fonts/conf.d ]]; then
		for file in "${EROOT}"/etc/fonts/conf.avail/*; do
			f=${file##*/}
			if [[ -L ${EROOT}/etc/fonts/conf.d/${f} ]]; then
				[[ -f ${ED}etc/fonts/conf.avail/${f} ]] \
					&& ln -sf ../conf.avail/"${f}" "${ED}"etc/fonts/conf.d/ &>/dev/null
			else
				[[ -f ${ED}etc/fonts/conf.avail/${f} ]] \
					&& rm "${ED}"etc/fonts/conf.d/"${f}" &>/dev/null
			fi
		done
	fi
	eend $?
}

pkg_postinst() {
	einfo "Cleaning broken symlinks in "${EROOT}"etc/fonts/conf.d/"
	find -L "${EROOT}"etc/fonts/conf.d/ -type l -delete

#	echo
#	ewarn "Please make fontconfig configuration changes using \`eselect fontconfig\`"
#	ewarn "Any changes made to /etc/fonts/fonts.conf will be overwritten."
#	ewarn
#	ewarn "If you need to reset your configuration to upstream defaults, delete"
#	ewarn "the directory ${EROOT}etc/fonts/conf.d/ and re-emerge fontconfig."
#	echo

	readme.gentoo_print_elog

	if [[ ${ROOT} = / ]]; then
		multilib_pkg_postinst() {
			ebegin "Creating global font cache for ${ABI}"
			"${EPREFIX}"/usr/bin/${CHOST}-fc-cache -srf
			eend $?
		}

		multilib_parallel_foreach_abi multilib_pkg_postinst
	fi
}
