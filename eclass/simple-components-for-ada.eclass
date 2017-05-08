# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

HOMEPAGE="https://sourceforge.net/projects/simplecomponentsforada/"
SRC_URI="mirror://sourceforge/simplecomponentsforada/components_${PV/./_}.tgz -> ${P}.tar.gz"

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

simple-components-for-ada-src_unpack() {
	cd "${WORKDIR}"
	mkdir "${P}" || die
	cd "${P}" || die
	unpack "${P}.tar.gz"
}
