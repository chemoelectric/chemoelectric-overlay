# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

HOMEPAGE="https://code.call-cc.org/"
IUSE=""

CHICKEN_EGG_PN=${PN/chicken-/}
CHICKEN_EGG_PN=${CHICKEN_EGG_PN/srfi/srfi-}
CHICKEN_EGG_P=${CHICKEN_EGG_PN}-${PV}

CHICKEN_MAJOR_VERSION=5

SRC_URI="
	https://code.call-cc.org/egg-tarballs/${CHICKEN_MAJOR_VERSION}/${CHICKEN_EGG_PN}/${CHICKEN_EGG_P}.tar.gz
		-> ${P}.tar.gz
"

S="${WORKDIR}/${CHICKEN_EGG_P}"

EXPORT_FUNCTIONS src_configure src_compile src_test src_install

chicken-egg_src_configure() {
	:
}

chicken-egg_src_compile() {
	chicken-install -n
}

chicken-egg_src_test() {
	# FIXME: Come up with a way to run the tests.
	:
}

chicken-egg_src_install() {
	DESTDIR="${D}" chicken-install
}
