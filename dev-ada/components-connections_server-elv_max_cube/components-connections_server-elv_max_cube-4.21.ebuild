# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SUB_DESCRIPTION="ELV MAX! Cube support"

inherit simple-components-for-ada

COMMON_DEPEND="
	=dev-ada/components-connections_server-${PV}*:=[single-tasking?,tracing?]
"
DEPEND+="${COMMON_DEPEND}"
RDEPEND+="${COMMON_DEPEND}"

SLOT="0"
KEYWORDS="~amd64"
