# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SUB_DESCRIPTION="secure server support"

inherit toolchain-funcs simple-components-for-ada

COMMON_DEPEND="
	=dev-ada/components-${PV}*:=[single-tasking?,tracing?]
	dev-db/unixODBC:*
"
DEPEND+="${COMMON_DEPEND}"
RDEPEND+="${COMMON_DEPEND}"

SLOT="0"
KEYWORDS="~amd64"

tc-getODBC_CONFIG() {
	tc-getPROG ODBC_CONFIG odbc_config "$@"
}

src_compile() {
	export odbc_libdir="$($(tc-getODBC_CONFIG) --lib-prefix)"
	export odbc="unixODBC"
	if use amd64 ; then
		export arch="x86_64"
#	elif use x86 ; then
#		export arch="i686"
	else
		die "This branch should never have been executed."
	fi
	simple-components-for-ada_src_compile
}

src_install() {
	export odbc_libdir="$($(tc-getODBC_CONFIG) --lib-prefix)"
	export odbc="unixODBC"
	if use amd64 ; then
		export arch="x86_64"
#	elif use x86 ; then
#		export arch="i686"
	else
		die "This branch should never have been executed."
	fi
	simple-components-for-ada_src_install
}
