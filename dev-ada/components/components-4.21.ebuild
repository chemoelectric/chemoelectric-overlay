# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# FIXME: Should we require the specific versions of strings_edit and
# tables, as here, or should we switch to >= notation?
DEPENDS_ON_LIBRARIES=(
	"=dev-ada/strings_edit-3.2*:="
	"=dev-ada/tables-1.13*:="
)

SUB_DESCRIPTION="core library"

inherit simple-components-for-ada

SLOT="0"
KEYWORDS="~amd64"

QA_EXECSTACK="
	usr/*/${PN}/${PN}.static*/${PN}/lib${PN}*.a:persistent-memory_pools-streams.o
	usr/*/${PN}/${PN}.relocatable*/${PN}/lib${PN}*.so*
"
