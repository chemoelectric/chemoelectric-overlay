# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Non-multilib build of Sortsmill Core.

SORTSMILL_REPO_TYPE=git
SORTSMILL_NEED_GNULIB=no

inherit eutils multiprocessing autotools sortsmill

DESCRIPTION="Sorts Mill Core Library"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"

IUSE="+atomic-ops +threads static-libs"
#IUSE+=" nls"

#LINGUA_REPERTOIRE_SRC=":fr"
#LINGUA_REPERTOIRE="${LINGUA_REPERTOIRE_SRC//:/ }"
#IUSE+=" ${LINGUA_REPERTOIRE_SRC//:/linguas_}"

LICENSE="GPL-3+"

_SORTSMILL_CORE_COMMON_DEPENDS="
	>=dev-libs/boehm-gc-7.2d-r1
	dev-libs/libunistring
	>=dev-libs/libpcre-8.10
	>=dev-libs/gmp-5
	>=dev-scheme/guile-2.0.9-r1
"
RDEPEND+=" ${SORTSMILL_CORE_COMMON_DEPENDS}"
DEPEND+=" ${SORTSMILL_CORE_COMMON_DEPENDS}"
DEPEND+=" atomic-ops? ( >=dev-libs/libatomic_ops-7.2d )"
DEPEND+=" sys-apps/sed virtual/awk sys-devel/m4"
unset _SORTSMILL_CORE_COMMON_DEPENDS

QA_AM_MAINTAINER_MODE=".*--language=autotest.*"

EXPORT_FUNCTIONS src_configure src_test

sortsmill-core_src_configure() {
	#use nls && strip-linguas ${LINGUA_REPERTOIRE}

	local enables="\
		$(use_with atomic-ops) \
		$(use_enable threads) \
		$(use_enable static-libs static)"
	#enables+=" $(use_enable nls)"

	econf --docdir="/usr/share/doc/${PF}" ${enables}
}

sortsmill-core_src_test() {
	emake check TESTSUITEFLAGS="-j$(makeopts_jobs)"
}
