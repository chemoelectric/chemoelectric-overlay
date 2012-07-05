# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

ECVS_SERVER="${PN}.cvs.sourceforge.net:/cvsroot/${PN}"
ECVS_MODULE="."
ECVS_LOCALNAME="${PN}"

inherit cvs eutils

DESCRIPTION="A collection of Fortran modules"
HOMEPAGE="http://fortranwiki.org/fortran/show/FLIBS"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="source"

DEPEND="virtual/pkgconfig
        sys-devel/gcc[fortran]"
RDEPEND="sys-devel/gcc[fortran]"

S="${WORKDIR}/${ECVS_LOCALNAME}"

src_prepare() {
	local cfg="make/makefile/Makefile-cfg"
	local patchdir="${FILESDIR}/${PV}"

	# Try to include configuration for the correct Fortran.
	sed -i "/^include Makefile-g95/d" "${cfg}" || echo "ignoring failed sed"
	sed -i "/^#include Makefile-gfortran/s/^#//" "${cfg}" || echo "ignoring failed sed"

	epatch "${patchdir}/qsort-intent.patch"
	epatch "${patchdir}/Wuninitialized-messages.patch"

	if use source; then
		find . -depth -type d -name CVSROOT -exec rm -rf "{}" ";"
		find . -depth -type d -name CVS -exec rm -rf "{}" ";"
		pushd ..
		cp -r "${ECVS_LOCALNAME}" "${ECVS_LOCALNAME}.src"
		popd
	fi
}

src_compile() {
	local rpath="/usr/$(get_libdir)"
	local shared_lib="lib${PN}.so"
	local soname="${shared_lib}.0"
	local fc="${FC-gfortran}"

	make -j1 -C make/makefile VERSION=release \
		FC="${fc}" \
		F90OPTS=" \
		${FCFLAGS} \
        -fPIC \
		-fno-backslash \
		-cpp \
		-std=gnu \
		-fcray-pointer \
		-fbounds-check \
		-Wall \
		-I../../src \
		-J../../lib/linux/x86_64/gfortran/release \
		-I../../lib/linux/x86_64/gfortran/release \
		-I../../src/datastructures \
		-I../../tests/support \
		-D_PLATFORM_FORTRAN_2003 \
		-D_PLATFORM_SYSTEM_SUBROUTINE \
		-D_PLATFORM_STAT_SUBROUTINE \
		-D_PLATFORM_CHDIR_SUBROUTINE \
		-D_VSTRING_POINTER \
		-D_VSTRINGLIST_ALLOCATABLE \
		-D_FS_RENAME_SUBROUTINE \
		-D_VFILE_RENAME_SUBROUTINE \
		-D_VFILE_GETCWD_SUBROUTINE \
		-D_PLATFORM_OS_LINUX" || \
		die "compilation failed"

	${fc} -shared -Wl,-rpath="${rpath}",-soname="${soname}" \
		-Wl,-whole-archive \
		bin/linux/*/gfortran/release/flibs.a \
		-Wl,-no-whole-archive \
		-o "${soname}" || \
		die "linking of shared library failed"
}

src_install() {
	local rpath="/usr/$(get_libdir)"
	local shared_lib="lib${PN}.so"
	local soname="${shared_lib}.0"
	local include_dir="/usr/include/${PN}"
	local pc_path="$(pkg-config --variable pc_path pkg-config)"
	local pc_dir="${pc_path/:*/}"
	local src_dir="/usr/lib/${PN}/${PV}/source"

	dolib.so "${soname}"
	dosym "${soname}" "${rpath}/${shared_lib}"

	dodir "${include_dir}"
	insinto "${include_dir}"
	doins lib/linux/*/gfortran/release/*.mod

	echo "libdir=${rpath}
includedir=${include_dir}

Name: ${PN}
Description: A collection of Fortran modules
Version: SCM
Libs: -L\${libdir} -l${PN}
Cflags: -I\${includedir}" > "${PN}.pc"
	dodir "${pc_dir}"
	insinto "${pc_dir}"
	doins "${PN}.pc"

	find doc -name "*.html" | xargs dohtml

	dodoc ChangeLog README

	if use source; then
		dodir "${src_dir}"
		pushd ..
		cp -r "${ECVS_LOCALNAME}.src"/* "${D}${src_dir}"
		popd
	fi
}
