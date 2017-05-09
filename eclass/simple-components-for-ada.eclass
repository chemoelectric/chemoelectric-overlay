# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit multiprocessing

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install

DESCRIPTION="Simple Components library for Ada: ${SUB_DESCRIPTION}"
HOMEPAGE="https://sourceforge.net/projects/simplecomponentsforada/"
SRC_URI="mirror://sourceforge/simplecomponentsforada/components_${PV/./_}.tgz -> components-${PV}.tar.gz"

IUSE="doc single-tasking tracing"

DEPEND="
	virtual/ada:*
	>=dev-ada/gprbuild-2016_p20170427191900
"
RDEPEND="
	virtual/ada:*
"

PATCHES=( "${FILESDIR}/components-${PV}-gentoo.patch" )

# Let us make the soname a simple mathematical function of the package
# version. Can someone come up with a better soname, given that we
# have little control over library version compatibility?
MAJOR_VERSION="${PV/.*/}"
MINOR_VERSION="${PV/*./}"
SO_VERSION="$(( 1000 * ${MAJOR_VERSION} + ${MINOR_VERSION} ))"
LIB_NAME="${PN}"
SO_EXTENSION=".so.${SO_VERSION}"

if [[ 4021 -le ${SO_VERSION} ]] ; then
	# Increase the value on the right side of the `-le', as long the
	# licensing stays as it is.
	if [[ "${SO_VERSION}" -le 4021 ]] ; then
		LICENSE="GPL-2+"
	fi
fi

atomic_access() {
	# Use Pragma-atomic on 64-bit *targets* (but *not* for 32-bit
	# builds on 64-bit systems).
	if use amd64 ; then
		echo Pragma-atomic
	else
		echo GCC-long-offsets
	fi
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

x_flags() {
	printf "%s" \
		   "-XLIBRARY_TYPE=${1}
		    -XCOMPONENTS_BUILD=${1}
			-XSTRINGS_EDIT_BUILD=${1}
			-XTABLES_BUILD=${1}
			-XAtomic_Access=$(atomic_access)
			-XTasking=${2}
			-XTraced_objects=${3}"
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

simple-components-for-ada_src_unpack() {
	cd "${WORKDIR}"
	mkdir "${P}" || die
	cd "${P}" || die
	unpack "components-${PV}.tar.gz"
}

simple-components-for-ada_src_prepare() {
	default

	# Keep only the gpr file for what we are building. Otherwise
	# we get the wrong gpr files for projects included with
	# `with'.
	mkdir BITBUCKET || die
	mv *.gpr BITBUCKET || die
	mv BITBUCKET/"${PN}".gpr . || die

	sed -e 's|@LIB_NAME@|'"${LIB_NAME}"'|g' \
		-e 's|@SO_EXTENSION@|'"${SO_EXTENSION}"'|g' \
		settings.gpr.in > settings.gpr || die
}

simple-components-for-ada_src_compile() {
	local gprbuild="${GPRBUILD:-gprbuild} -j$(makeopts_jobs) -v -p -R -P${PN}"
	for lt in $(library_types) ; do
		for tasking in $(tasking_options) ; do
			for tracing in $(tracing_options) ; do
				${gprbuild} $(x_flags "${lt}" "${tasking}" "${tracing}") || die
			done
		done
	done
}

simple-components-for-ada_src_install() {
	local gprinstall="${GPRINSTALL:-gprinstall} -v -p -f -P${PN} \
		  --prefix=${D}/usr --link-lib-subdir=$(get_libdir) \
		  --install-name=${PN}"
	for lt in $(library_types) ; do
		for tasking in $(tasking_options) ; do
			for tracing in $(tracing_options) ; do
				local bn="$(build_name "${lt}" "${tasking}" "${tracing}")"
				${gprinstall} $(x_flags "${lt}" "${tasking}" "${tracing}") \
							  --build-var="COMPONENTS_BUILD" \
							  --build-name="${bn}" \
							  --lib-subdir="$(get_libdir)/${PN}/${PN}.${bn}" \
							  --sources-subdir="include/${PN}/${PN}.${bn}"
			done
		done
	done

	einstalldocs

	dodoc readme_components.txt
	use doc && {
		docinto html
		dodoc components.htm *.jpg *.gif
	}
}
