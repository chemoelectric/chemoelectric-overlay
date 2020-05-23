# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A trampoline for running CHICKEN Scheme scripts"
HOMEPAGE="https://wiki.call-cc.org/writing%20portable%20scripts"
SRC_URI=""
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-scheme/chicken-5.2.0:*
"
DEPEND=""

S="${WORKDIR}"

src_install() {
	dobin "${FILESDIR}/chicken-script"
}

pkg-postinst() {
		elog "You may write scripts in CHICKEN by using the shebang"
		elog
		elog "    #!/usr/bin/env chicken-script"
		elog
		elog "See https://wiki.call-cc.org/writing%20portable%20scripts"
		elog "for more information."
}
