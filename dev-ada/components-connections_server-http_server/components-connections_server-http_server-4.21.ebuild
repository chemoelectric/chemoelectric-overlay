# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DEPENDS_ON_LIBRARIES=(
	"=dev-ada/components-connections_server-${PV}*:=[single-tasking?,tracing?]"
)

SUB_DESCRIPTION="HTTP server"

inherit simple-components-for-ada

SLOT="0"
KEYWORDS="~amd64"
