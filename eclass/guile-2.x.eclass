# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit multilib-build
inherit eutils
inherit autotools
inherit flag-o-matic

DESCRIPTION="The GNU Guile extension language (Scheme) and library"
HOMEPAGE="https://www.gnu.org/software/guile/"

_scm_sources() {
	[[ "${PV}" == "2.0.9999" || "${PV}" == "2.2.9999" || "${PV}" == "3.0.9999" ]]
}

_series() {
	case "${PV}" in
		2.0*)
			echo 2.0
			;;
		2.2*)
			echo 2.2
			;;
		3.0*)
			echo 3.0
			;;
		*)
			die "There is a bug in this eclass."
			;;
	esac
}

if $(_scm_sources); then
	inherit git-r3
	EGIT_REPO_URI="https://git.savannah.gnu.org/git/guile.git"
	[[ "$(_series)" == "2.0" ]] && EGIT_BRANCH="stable-2.0"
	[[ "$(_series)" == "2.2" ]] && EGIT_BRANCH="stable-2.2"
	[[ "$(_series)" == "3.0" ]] && EGIT_BRANCH="stable-3.0"
else
	SRC_URI="mirror://gnu/guile/${P}.tar.xz"
fi

LICENSE="LGPL-3"
IUSE="doc networking +regex +deprecated nls debug-malloc debug slib +threads"

RDEPEND="
	!dev-scheme/guile:0
	!dev-scheme/guile:12
	!dev-scheme/guile:2
	app-eselect/eselect-guile:=
	>=dev-libs/boehm-gc-7.0[threads?,${MULTILIB_USEDEP}]
	dev-libs/gmp:0[${MULTILIB_USEDEP}]
	dev-libs/libffi:*[${MULTILIB_USEDEP}]
	dev-libs/libunistring:*[${MULTILIB_USEDEP}]
	sys-devel/gettext:*[${MULTILIB_USEDEP}]
	>=sys-devel/libtool-1.5.6:*
	slib? ( dev-scheme/slib:* )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig:*
	doc? ( sys-apps/texinfo:* )
"

# We use our own slot system and block those of the "gentoo" and
# "lisp" repositories.
SLOT="$(_series)"

EXPORT_FUNCTIONS \
	src_prepare \
	src_configure \
	src_compile \
	src_test \
	src_install \
	pkg_postinst \
	pkg_postrm \
	pkg_config

# Inside-of-source builds, because I cannot make sure upstream keeps
# outside-of-source builds working correctly.
ECONF_SOURCE="."

_abi_count() {
	local abis=( $(multilib_get_enabled_abis) )
	echo ${#abis[@]}
}

_build_is_multilib() {
	(( 1 < $(_abi_count) ))
}

_build_dir() {
	echo "${WORKDIR}/build.${1}"
}

_libincludedir() {
	# At most one or a few of the include files will be ABI-specific,
	# but I prefer they all be pointed to by "includedir" in the .pc
	# file, so place them all under $(get_libdir).
	echo "${EPREFIX}/usr/$(get_libdir)/guile/$(_series)/include"
}

_compare_files() {
	local abis=( $(multilib_get_enabled_abis) )
	local libdir1="$(get_abi_LIBDIR ${abis[0]})"
	local dir1="${ED}/usr/${libdir1}/guile/$(_series)/include/guile/$(_series)/"
	local matched="yes"
	local i
	typeset -i i
	for (( i=1; i < ${#abis[@]}; i++ )); do
		local libdir2="$(get_abi_LIBDIR ${abis[i]})"
		local dir2="${ED}/usr/${libdir2}/guile/$(_series)/include/guile/$(_series)/"
		if cmp -s "${dir1}/${1}" "${dir2}/${1}"; then
			:
		else
			matched="no"
		fi
	done
	echo "${matched}"
}

_move_h_files() {
	# Move to /usr/include/guile/$(_series) all the *.h files that are the
	# same for all ABIs. Provide symlinks so they can still be found
	# by using the includedir specified to pkg-config.

	local includedir="/usr/include/guile/$(_series)"

	einfo "Moving (to ${includedir}) all the C header files that"
	einfo "are the same across ABIs ..."

	dodir "${includedir}/libguile"

	local abis=( $(multilib_get_enabled_abis) )
	local libdir1="$(get_abi_LIBDIR ${abis[0]})"
	local dir1="${ED}/usr/${libdir1}/guile/$(_series)/include/guile/$(_series)/"
	pushd "${dir1}" >/dev/null || die
	local h_files=`find . -name \*.h -print`
	popd >/dev/null
	for f in ${h_files}; do
		local matched="$(_compare_files "${f}")"
		if [[ "${matched}" == "yes" ]]; then
			# The .h file is the same despite the different ABIs. Move
			# it to /usr/include and provide symlinks in place of the
			# original files.
			mv "${dir1}/${f}" "${ED}/${includedir}/${f}" || die
			for abi in $(multilib_get_enabled_abis); do
				local libdir2="$(get_abi_LIBDIR ${abi})"
				local dir2="${ED}/usr/${libdir2}/guile/$(_series)/include/guile/$(_series)/"
				ln -s -r -f "${ED}/${includedir}/${f}" "${dir2}/${f}" || die
			done
		fi
	done

	einfo "done."
}

guile-2.x_src_prepare() {
	default
	$(_scm_sources) && eautoreconf
}

guile-2.x_multilib_src_configure() {
	#
	# Configure inside-of-source builds.
	#
	# Outside-of-source builds _should_ work, but in this do not
	# control the upstream sources. So why take chances on breakage?
	# (Actually, there are good reasons, but I do not want the extra
	# burden.)
	#
	cp -p -R "${S}" "$(_build_dir "${ABI}")" || die
	pushd "$(_build_dir "${ABI}")" || die

	# see bug #178499
	filter-flags -ftree-vectorize

	local includedir_flag=""
	$(_build_is_multilib) && \
		includedir_flag="--includedir=$(_libincludedir)"

	#will fail for me if posix is disabled or without modules -- hkBst
	econf \
		--program-prefix="${CHOST}-" \
		--program-suffix="-$(_series)" \
		--infodir="${EPREFIX}"/usr/share/info/guile-$(_series) \
		${includedir_flag} \
		--disable-error-on-warning \
		--disable-static \
		--enable-posix \
		$(use_enable networking) \
		$(use_enable regex) \
		$(use_enable deprecated) \
		$(use_enable nls) \
		--disable-rpath \
		$(use_enable debug-malloc) \
		$(use_enable debug guile-debug) \
		$(use_with threads) \
		--with-modules

	popd
}

guile-2.x_multilib_src_compile() {
	pushd "$(_build_dir "${ABI}")" || die
	emake
	popd
}

guile-2.x_multilib_src_test() {
	pushd "$(_build_dir "${ABI}")" || die
	emake check
	popd
}

guile-2.x_multilib_src_install() {
	pushd "$(_build_dir "${ABI}")" || die

	emake install DESTDIR="${ED}"

	# For the default ABI, make links without the "${CHOST}-".
	if [[ "${ABI}" == "${DEFAULT_ABI}" ]]; then
		pushd "${ED}"/usr/bin >/dev/null || die
		for p in guile guild guile-{config,snarf,tools} ; do
			ln -s "${CHOST}-${p}-$(_series)" "${p}-$(_series)" || die
		done
		popd >/dev/null
		pushd "${ED}"/usr/share/man/man1 >/dev/null || die
		ln -s "${CHOST}-guile-$(_series).1" "guile-$(_series).1" || die
		popd >/dev/null
	fi

	# For backwards compatibility, provide symlinks from
	# <filename>-2.0 to <filename>-2.
	if [[ "$(_series)" == "2.0" ]]; then
		pushd "${ED}"/usr/bin >/dev/null || die
		for p in guile guild guile-{config,snarf,tools} ; do
			ln -s "${CHOST}-${p}-$(_series)" "${CHOST}-${p}-2" || die
			if [[ "${ABI}" == "${DEFAULT_ABI}" ]]; then
				ln -s "${CHOST}-${p}-$(_series)" "${p}-2" || die
			fi
		done
		popd >/dev/null
	fi

	# Maybe there is a proper way to do this? Symlink handled by eselect
	mv "${ED}"/usr/share/aclocal/guile.m4 \
	   "${ED}"/usr/share/aclocal/guile-$(_series).m4 \
		|| die

	if is_final_abi; then
		if [[ "$(_series)" == "2.0" ]]; then
			# For backwards compatibility, provide a symlink from
			# guile-2.0.m4 to guile-2.m4.
			ln -r -s \
			   "${ED}"/usr/share/aclocal/guile-$(_series).m4 \
			   "${ED}"/usr/share/aclocal/guile-2.m4 \
				|| die

			# Also one for the manpage.
			ln -r -s \
			   "${ED}/usr/share/man/man1/${CHOST}-guile-$(_series).1" \
			   "${ED}/usr/share/man/man1/guile-2.1" \
				|| die
		fi

		if use doc; then
			make -C doc html MAKEINFOHTML='makeinfo --html --no-split' \
				|| die
			dodoc doc/ref/guile.html doc/r5rs/r5rs.html
		fi
	fi

	popd
}

guile-2.x_src_configure() {
	multilib_foreach_abi guile-2.x_multilib_src_configure
}

guile-2.x_src_compile() {
	multilib_foreach_abi guile-2.x_multilib_src_compile
}

guile-2.x_src_test() {
	multilib_foreach_abi guile-2.x_multilib_src_test
}

guile-2.x_src_install() {
	multilib_foreach_abi guile-2.x_multilib_src_install

	# The following step is not necessary, but we do it anyway.
	$(_build_is_multilib) && _move_h_files

	# Our multilib installation process does not keep the timestamps
	# of .scm files earlier than those of all the .go files. Therefore
	# we have to update the timestamps of .go files. (It is harmless
	# to do so in non-multilib builds.)
	touch $(find "${ED}" -name \*.go -print) || die

	# necessary for registering slib, see bug 206896
	keepdir /usr/share/guile/site

	dodoc AUTHORS ChangeLog GUILE-VERSION HACKING NEWS README THANKS
}

guile-2.x_pkg_postinst() {
	[ "${EROOT}" == "/" ] && pkg_config
	eselect guile update --if-unset
}

guile-2.x_pkg_postrm() {
	eselect guile update --if-unset
}

guile-2.x_pkg_config() {
	if use slib; then
		einfo "Registering slib with guile"
		install_slib_for_guile
	fi
}

#guile-2.x_pkg_prerm() {
#	if use slib; then
#		rm -f "${EROOT}"/usr/share/guile/site/slibcat
#	fi
#}
