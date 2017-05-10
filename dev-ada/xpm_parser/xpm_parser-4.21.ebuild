# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit simple-components-for-ada

DESCRIPTION="An Ada library for parsing a C program that contains an XPM image"

COMMON_DEPEND="
	=dev-ada/components-${PV}*:=[single-tasking?,tracing?]
"
DEPEND+="${COMMON_DEPEND}"
RDEPEND+="${COMMON_DEPEND}"

SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	pushd xpm || die
	simple-components-for-ada_src_compile
	popd || die
}

src_install() {
	einstalldocs
	dodoc readme_components.txt
	use doc && simple-components-for-ada-install-extra-docs

	pushd xpm || die
	simple-components-for-ada-install
	dodoc readme.txt
	popd || die
}
