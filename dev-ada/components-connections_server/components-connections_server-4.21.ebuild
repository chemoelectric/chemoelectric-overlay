# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DEPENDS_ON_LIBRARIES=(
	"=dev-ada/components-${PV}*:=[single-tasking?,tracing?]"
)

SUB_DESCRIPTION="connections server"

inherit simple-components-for-ada

SLOT="0"
KEYWORDS="~amd64"

