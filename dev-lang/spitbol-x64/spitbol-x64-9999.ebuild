# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="https://github.com/spitbol"
EGIT_REPO_URI="https://github.com/spitbol/x64.git"

LICENSE="GPL-2+"

SLOT="0"
KEYWORDS="~amd64"

IUSE="+binary examples"

QA_PREBUILT="/usr/bin/sbl"
QA_WX_LOAD="/usr/bin/sbl"

src_prepare() {
	if use binary; then
		:
	else
		die "Building dev-lang/spitbol-x64 from sources is not yet implemented."
	fi
	default
}

src_configure() {
	if use binary; then
		:
	else
		:						#  FIXME
	fi
}

src_compile() {
	if use binary; then
		:
	else
		:						#  FIXME
	fi
}

src_install() {
	dodoc README*

	if use binary; then
		dobin bin/sbl
	else
		:						#  FIXME
	fi

	if use examples; then
		dodoc -r test
		dodoc -r demos
	fi
}
