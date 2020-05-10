# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Multilib build of Sortsmill Core.

SORTSMILL_REPO_TYPE=git
SORTSMILL_NEED_GNULIB=no

inherit eutils
inherit multiprocessing
inherit multilib-build
inherit toolchain-funcs
inherit sortsmill

DESCRIPTION="Sorts Mill Core Library"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"

IUSE="+atomic-ops +threads static-libs"
#IUSE+=" nls"

#LINGUA_REPERTOIRE_SRC=":fr"
#LINGUA_REPERTOIRE="${LINGUA_REPERTOIRE_SRC//:/ }"
#IUSE+=" ${LINGUA_REPERTOIRE_SRC//:/linguas_}"

LICENSE="GPL-3+"

_SORTSMILL_CORE_COMMON_DEPENDS="
	>=dev-libs/boehm-gc-7.2d-r1[${MULTILIB_USEDEP}]
	dev-libs/libunistring[${MULTILIB_USEDEP}]
	>=dev-libs/libpcre-8.10[${MULTILIB_USEDEP}]
	>=dev-libs/gmp-5[${MULTILIB_USEDEP}]
	>=dev-scheme/guile-2.0.9-r1
"
RDEPEND+=" ${SORTSMILL_CORE_COMMON_DEPENDS}"
DEPEND+=" ${SORTSMILL_CORE_COMMON_DEPENDS}"
DEPEND+=" atomic-ops? ( >=dev-libs/libatomic_ops-7.2d[${MULTILIB_USEDEP}] )"
DEPEND+=" sys-apps/sed virtual/awk sys-devel/m4"
unset _SORTSMILL_CORE_COMMON_DEPENDS

QA_AM_MAINTAINER_MODE=".*--language=autotest.*"

EXPORT_FUNCTIONS src_configure src_compile src_test src_install

ECONF_SOURCE="${S}"

_build_dir() {
	echo "${WORKDIR}/build.${1}"
}

sortsmill-core-r1_multilib_src_configure() {
	#
	# Configure outside-of-source builds.
	#

	#use nls && strip-linguas ${LINGUA_REPERTOIRE}

	local enables="\
		$(use_with atomic-ops) \
		$(use_enable threads) \
		$(use_enable static-libs static)"
	#enables+=" $(use_enable nls)"

	mkdir "$(_build_dir "${ABI}")" || die
	pushd "$(_build_dir "${ABI}")" >/dev/null || die
	econf --without-ats ${enables}
	popd >/dev/null
}

sortsmill-core-r1_multilib_src_compile() {
	pushd "$(_build_dir "${ABI}")" >/dev/null || die
	emake
	popd >/dev/null
}

sortsmill-core-r1_multilib_src_test() {
	pushd "$(_build_dir "${ABI}")" >/dev/null || die
	emake check TESTSUITEFLAGS="-j$(makeopts_jobs)"
	popd >/dev/null
}

sortsmill-core-r1_multilib_src_install() {
	pushd "$(_build_dir "${ABI}")" >/dev/null || die
	emake DESTDIR="${ED}" install
	popd >/dev/null
}

sortsmill-core-r1_src_configure() {
	multilib_foreach_abi sortsmill-core-r1_multilib_src_configure
}

sortsmill-core-r1_src_compile() {
	multilib_foreach_abi sortsmill-core-r1_multilib_src_compile
}

sortsmill-core-r1_src_test() {
	multilib_foreach_abi sortsmill-core-r1_multilib_src_test
}

sortsmill-core-r1_src_install() {
	multilib_foreach_abi sortsmill-core-r1_multilib_src_install
	dodoc AUTHORS ChangeLog NEWS README
}
