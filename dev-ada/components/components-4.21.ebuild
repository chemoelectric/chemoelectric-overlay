# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# FIXME: Consider adding build types for Object_Tracing_Mode and
# Tasking_Mode options.

inherit multiprocessing

DESCRIPTION="Simple Components library for Ada"
HOMEPAGE="https://sourceforge.net/projects/simplecomponentsforada/"
SRC_URI="mirror://sourceforge/simplecomponentsforada/${PN}_${PV/./_}.tgz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="single-tasking tracing"

# FIXME: Should we require the specific versions of strings_edit and
# tables, as here, or should we switch to >= notation?
COMMON_DEPEND="
	virtual/ada:*
	=dev-ada/strings_edit-3.2*:*
	=dev-ada/tables-1.13*:*
"
DEPEND="
	${COMMON_DEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900
"
RDEPEND="
	${COMMON_DEPEND}
"

QA_EXECSTACK="
	usr/*/components/components.static*/components/libcomponents*.a:persistent-memory_pools-streams.o
	usr/*/components/components.relocatable*/components/libcomponents*.so*
"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )

DOCS="readme_components.txt"
HTML_DOCS="components.htm *.jpg *.gif"

# Let us make the soname a simple mathematical function of the package
# version. Can someone come up with a better soname, given that we
# have little control over library version compatibility?
MAJOR_VERSION="${PV/.*/}"
MINOR_VERSION="${PV/*./}"
SO_VERSION="$(( 1000 * ${MAJOR_VERSION} + ${MINOR_VERSION} ))"
LIB_NAME="${PN}"
SO_EXTENSION=".so.${SO_VERSION}"

atomic_access() {
	# Use Pragma-atomic on 64-bit *targets* (but *not* for 32-bit
	# builds on 64-bit systems).
	if use amd64 ; then
		echo Pragma-atomic
	else
		echo GCC-long-offsets
	fi
}

x_flags() {
	printf "%s" \
		   "-XLIBRARY_TYPE=${1}
			-XSTRINGS_EDIT_BUILD=${1}
			-XTABLES_BUILD=${1}
			-XAtomic_Access=$(atomic_access)
			-XTasking=${2}
			-XTraced_objects=${3}"
}

build_name() {
	if [[ "${2}" == "Single" ]] ; then
		if  [[ "${3}" == "On" ]] ; then
			echo "${1}.single_tasking.tracing"
		else
			echo "${1}.single_tasking"
		fi
	else
		if  [[ "${3}" == "On" ]] ; then
			echo "${1}.tracing"
		else
			echo "${1}"
		fi
	fi
}

library_types() {
	echo "static static-pic relocatable"
}

tasking_options() {
	if use single-tasking ; then
		echo "Multiple Single"
	else
		echo "Multiple"
	fi
}

tracing_options() {
	if use tracing ; then
		echo "Off On"
	else
		echo "Off"
	fi
}

src_unpack() {
	cd "${WORKDIR}"
	mkdir "${P}" || die
	cd "${P}" || die
	unpack "${P}.tar.gz"
}

src_prepare() {
	default
	sed -i \
		-e 's|@LIB_NAME@|'"${LIB_NAME}"'|g' "${PN}.gpr" \
		-e 's|@SO_EXTENSION@|'"${SO_EXTENSION}"'|g' "${PN}.gpr" \
		|| die
	mv test_tables examples || die
	for gpr in *.gpr ; do
		# Keep only the gpr file for what we are building. Otherwise
		# we get the wrong gpr files for projects included with
		# `with'.
		if [[ "${gpr}" != "${PN}.gpr" ]] ; then
			rm "${gpr}" || die
		fi
	done
}

src_compile() {
	local gprbuild="${GPRBUILD:-gprbuild} -j$(makeopts_jobs) -v -p -R -P${PN}"
	for lt in $(library_types) ; do
		for tasking in $(tasking_options) ; do
			for tracing in $(tracing_options) ; do
				${gprbuild} $(x_flags "${lt}" "${tasking}" "${tracing}") || die
			done
		done
	done
}

src_install() {
	local gprinstall="${GPRINSTALL:-gprinstall} -v -p -f -P${PN} \
		  --prefix=${D}/usr --link-lib-subdir=$(get_libdir) \
		  --install-name=${PN}"
	for lt in $(library_types) ; do
		for tasking in $(tasking_options) ; do
			for tracing in $(tracing_options) ; do
				local bn="$(build_name "${lt}" "${tasking}" "${tracing}")"
				${gprinstall} $(x_flags "${lt}" "${tasking}" "${tracing}") \
							  --build-name="${bn}" \
							  --lib-subdir="$(get_libdir)/${PN}/${PN}.${bn}" \
							  --sources-subdir="include/${PN}/${PN}.${bn}"
			done
		done
	done
	einstalldocs
}
