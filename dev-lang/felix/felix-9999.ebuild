# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib toolchain-funcs git-r3

DESCRIPTION="'The fastest scripting language on Earth'"
HOMEPAGE="http://felix-lang.org"
EGIT_REPO_URI="https://github.com/felix-lang/felix.git"
LICENSE="felix-lang"

# FIXME: I think it should be possible to do version slots for Felix,
# although the desirability of doing so may be low at the moment.
SLOT="0"

KEYWORDS=""
IUSE=""

# FIXME: Some of these dependencies should be USE-dependent.
#
# FIXME: Is Python needed at runtime? Do we really need the sqlite
# support?
#
# FIXME: Is OCaml needed at runtime? (make install does install some
# OCaml files)
#
# FIXME: What other dependencies are there?
#
RDEPEND="
	>=dev-lang/python-3.1[sqlite]
	>=dev-lang/ocaml-3.11[ocamlopt]
	dev-libs/gmp[cxx]
	dev-libs/libxml2
	media-libs/libsdl
	net-libs/zeromq
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i \
		-e 's:^\(PREFIX[ 	]*\(?\|\)=[ 	]*\).*:\1/usr:' \
		-e 's:^\(INSTALLROOT[ 	]*\(?\|\)=[ 	]*\).*:\1${PREFIX}/'"$(get_libdir)"'/felix:' \
		Makefile \
		|| die "sed of Makefile failed"
	sed -i \
		-e 's:^\([ 	]*var[ 	][ 	]*PREFIX[ 	]*=[ 	]*Filename\:\:join[ 	]*(\)[ 	]*"/usr",[ 	]*"local",[ 	]*"lib"[ 	]*)[ 	]*;:\1"/usr","'"$(get_libdir)"'");:' \
		src/lib/std/felix/config.flx \
		|| die "sed of src/lib/std/felix/config.flx failed"
}

src_compile() {
	export FBUILD_PARAMS="--prefix=/usr --libdir=\"/usr/$(get_libdir)\" \
		--build-cc=\"$(tc-getCC)\" --build-cxx=\"$(tc-getCXX)\" \
		--host-cc=\"$(tc-getCC)\" --host-cxx=\"$(tc-getCXX)\" \
		--target-cc=\"$(tc-getCC)\" --target-cxx=\"$(tc-getCXX)\""
	make build || die "make build failed"
	make doc || die "make doc failed"
}

src_test() {
	make test || die "make test failed"
}

src_install() {
	make install \
		INSTALLROOT="${D}/usr/$(get_libdir)/felix" \
		PREFIX="${D}/usr" \
		|| die "make install failed"
}
