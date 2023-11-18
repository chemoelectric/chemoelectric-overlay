# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A trampoline for running CHICKEN Scheme scripts"
HOMEPAGE="https://wiki.call-cc.org/writing%20portable%20scripts"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND=">=dev-scheme/chicken-5.2.0:*"
S="${WORKDIR}"

src_install() {
	cp "${FILESDIR}/chicken-script" "." || die
	chmod 755 "chicken-script" || die
	dobin "chicken-script"
}

pkg_postinst() {
	elog "You may write scripts in CHICKEN by using the shebang"
	elog
	elog "    #!/usr/bin/env chicken-script"
	elog
	elog "See https://wiki.call-cc.org/writing%20portable%20scripts"
	elog "for more information."
}
