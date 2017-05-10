# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SUB_DESCRIPTION="core library"

inherit simple-components-for-ada

# FIXME: Should we require the specific versions of strings_edit and
# tables, as here, or should we switch to >= notation?
COMMON_DEPEND="
	=dev-ada/strings_edit-3.2*:=
	=dev-ada/tables-1.13*:=
"
DEPEND+="${COMMON_DEPEND}"
RDEPEND+="${COMMON_DEPEND}"

SLOT="0"
KEYWORDS="~amd64"

IUSE+=" examples"

QA_EXECSTACK="
	usr/*/${PN}/${PN}.static*/${PN}/lib${PN}*.a:persistent-memory_pools-streams.o
	usr/*/${PN}/${PN}.relocatable*/${PN}/lib${PN}*.so*
"

src_prepare() {
	simple-components-for-ada_src_prepare

	# Modify the parser-examples to use the installed ‘components’
	# project.
	if use examples ; then
		sed -i \
			-e "s|\.\./\.\./components.gpr|components|" \
			parser-examples/*/*.gpr || die
		sed -i \
			-e "s| -I\.\./\.\./||" \
			-e "s|gnatmake .*\.adb|gprbuild -j0|" \
			parser-examples/*/readme.txt || die
	fi
}

src_install() {
	simple-components-for-ada_src_install

	if use examples ; then
		docinto examples
		dodoc -r parser-examples/*
		docinto ..
	fi
}
