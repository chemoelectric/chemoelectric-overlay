# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DEPENDS_ON_LIBRARIES=(
	"=dev-ada/components-${PV}*:=[single-tasking?,tracing?]"
)

SUB_DESCRIPTION="GnuTLS interface"

inherit simple-components-for-ada

DEPEND+=" virtual/pkgconfig:* net-libs/gnutls:*"
RDEPEND+=" net-libs/gnutls:*"

SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	simple-components-for-ada_src_prepare
	sed -i -e "s|@PKGCONFIG_LIBS@|$(pkg-config --libs gnutls)|g" "${PN}".gpr
}
