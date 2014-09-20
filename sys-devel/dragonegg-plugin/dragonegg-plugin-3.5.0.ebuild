# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# FIXME: This ebuild is not very good. Improve it.
#

EAPI=5
inherit eutils multilib toolchain-funcs

DESCRIPTION="GCC plugin that uses LLVM for optimization and code generation"
HOMEPAGE="http://dragonegg.llvm.org/"
SRC_URI="http://llvm.org/releases/${PV}/dragonegg-${PV}.src.tar.xz
	test? ( http://llvm.org/releases/${PV}/llvm-${PV}.src.tar.xz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="llvm-plugins test"

DEPEND="
	>=sys-devel/gcc-4.7
	=sys-devel/llvm-${PV}*"
RDEPEND="${DEPEND}"

S="${WORKDIR}/dragonegg-${PV}.src"

for_all_gcc_targets() {
	for target in ${DRAGONEGG_GCC_TARGETS} ; do
		${1} ${target}
	done
}

check_gcc_target() {
	local major_version=`echo ${1} | sed -e 's/^\([0-9][0-9]*\).*$/\1/'`
	local minor_version=`echo ${1} | sed -e 's/^[0-9][0-9]*\.\([0-9][0-9]*\).*$/\1/'`
	[[ ${major_version} -lt 4 || ( ${major_version} -eq 4 && ${minor_version} -lt 6 ) ]] && \
		die "GCC < 4.6 is not supported by this ebuild"
}

pkg_setup() {
	[[ -z "${DRAGONEGG_GCC_TARGETS}" ]] && {
		die "Please set DRAGONEGG_GCC_TARGETS, in /etc/portage/make.conf or in some other appropriate place"
	}

	for_all_gcc_targets check_gcc_target
}

prepare_one_gcc_target() {
	cp -R "${S}" "${S}-${1}"
}

src_prepare() {
	for_all_gcc_targets prepare_one_gcc_target
}

compile_one_gcc_target() {
	cd "${S}-${1}"

	# GCC: compiler with which to use the plugin.
	local emake_opts="VERBOSE=1 CC=${CHOST}-gcc-${1} GCC=${CHOST}-gcc-${1} CXX=${CHOST}-g++-${1}"
	use llvm-plugins && emake_opts+=" ENABLE_LLVM_PLUGINS=1"

	emake ${emake_opts}
}

src_compile() {
	for_all_gcc_targets compile_one_gcc_target
}

test_one_gcc_target() {
	# GCC languages are determined via locale-dependant gcc -v output
	export LC_ALL=C

	cd "${S}-${1}"
	emake LIT_DIR="${WORKDIR}"/llvm-${PV}/utils/lit check
}

src_test() {
	for_all_gcc_targets test_one_gcc_target
}

install_one_gcc_target() {
	cd "${S}-${1}"

	exeinto "/usr/$(get_libdir)/gcc/${CHOST}/${1}/plugin"
	doexe dragonegg.so
}

src_install() {
	for_all_gcc_targets install_one_gcc_target
	dodoc README
}

pkg_postinst() {
	elog "To use dragonegg, run gcc as usual, with an extra command line argument:"
	elog "	-fplugin=dragonegg"
}
