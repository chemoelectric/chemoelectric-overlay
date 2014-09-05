# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-2

DESCRIPTION="Racket's syntax-parse adapted for Guile"
HOMEPAGE="https://gitorious.org/guile-syntax-parse"
EGIT_REPO_URI="https://gitorious.org/guile-syntax-parse/guile-syntax-parse.git"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

#
# FIXME: Patch it to work with guile:2.2. The necessary changes seem
# minor. (Also put in a push request for those changes.)
#
# FIXME: Make this ebuild install for multiple Guile versions.
#
DEPEND="dev-scheme/guile:2"
RDEPEND="${DEPEND}"

GUILE_TARGETS="2.0"

#
# FIXME: Write an eclass.
#

for_each_guile_target() {
	for t in "${GUILE_TARGETS}"; do
		pushd "${S}-${t}"
		"${1}" "${t}"
		popd
	done
}

unpack_one_target() {
	cp -R "${S}" "${S}-${1}" || die "cp -R failed"
}

src_unpack() {
	git-2_src_unpack
	for_each_guile_target unpack_one_target
}

prepare_one_target() {
	sed -i -e 's/GUILE_PKG(\[2\.2 2\.0\])/GUILE_PKG(['"${1}"'])/' \
		configure.ac || die "sed failed"
	eautoreconf
}

src_prepare() {
	for_each_guile_target prepare_one_target
}

configure_one_target() {
	econf
}

src_configure() {
	for_each_guile_target configure_one_target
}

compile_one_target() {
	emake
}

src_compile() {
	for_each_guile_target compile_one_target
}

install_one_target() {
	emake install DESTDIR="${D}"
}

src_install() {
	for_each_guile_target install_one_target
}
