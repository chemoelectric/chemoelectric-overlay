# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Multilib build of libunicodenames.

SORTSMILL_REPO_TYPE=git
SORTSMILL_NEED_GNULIB=no

inherit eutils
inherit multiprocessing
inherit multilib-build
inherit sortsmill

DESCRIPTION="a library for retrieving Unicode annotation data"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"

IUSE="nls static-libs"

IUSE+=" make-libunicodenames-db"

LINGUA_REPERTOIRE_SRC=":fr"
LINGUA_REPERTOIRE="${LINGUA_REPERTOIRE_SRC//:/ }"
IUSE+=" ${LINGUA_REPERTOIRE_SRC//:/l10n_}"

LICENSE="LGPL-3+"

DEPEND+=" sys-apps/sed"

QA_AM_MAINTAINER_MODE=".*--language=autotest.*"

EXPORT_FUNCTIONS src_configure src_compile src_test src_install

ECONF_SOURCE="${S}"

_build_dir() {
	echo "${WORKDIR}/build.${1}"
}

sortsmill-libunicodenames-r1_multilib_src_configure() {
	#
	# Configure outside-of-source builds.
	#

	use nls && strip-linguas ${LINGUA_REPERTOIRE}

	local enables="\
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_enable make-libunicodenames-db)"

	mkdir "$(_build_dir "${ABI}")" || die
	pushd "$(_build_dir "${ABI}")" || die
	econf ${enables}
	popd
}

sortsmill-libunicodenames-r1_multilib_src_compile() {
	pushd "$(_build_dir "${ABI}")" || die
	emake
	popd
}

sortsmill-libunicodenames-r1_multilib_src_test() {
	pushd "$(_build_dir "${ABI}")" || die
	emake check TESTSUITEFLAGS="-j$(makeopts_jobs)"
	popd
}

sortsmill-libunicodenames-r1_multilib_src_install() {
	pushd "$(_build_dir "${ABI}")" || die
	emake install DESTDIR="${D}"
	popd
}

sortsmill-libunicodenames-r1_src_configure() {
	multilib_foreach_abi sortsmill-libunicodenames-r1_multilib_src_configure
}

sortsmill-libunicodenames-r1_src_compile() {
	multilib_foreach_abi sortsmill-libunicodenames-r1_multilib_src_compile
}

sortsmill-libunicodenames-r1_src_test() {
	multilib_foreach_abi sortsmill-libunicodenames-r1_multilib_src_test
}

sortsmill-libunicodenames-r1_src_install() {
	multilib_foreach_abi sortsmill-libunicodenames-r1_multilib_src_install
	dodoc AUTHORS ChangeLog NEWS README
}
