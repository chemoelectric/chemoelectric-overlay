# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ADA_COMPAT=( gnat_202{0,1} gcc_12_2_0 )

inherit git-r3
inherit ada

DESCRIPTION="Ada LIbrary REpository"
HOMEPAGE="https://alire.ada.dev"
EGIT_REPO_URI="https://github.com/alire-project/alire.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="${ADA_REQUIRED_USE}"
BDEPEND="
	${ADA_DEPS}
	dev-ada/gprbuild:*
"

src_compile() {
	gprbuild -j0 -P alr_env -v -cargs:Ada ${ADAFLAGS} -cargs:C ${CFLAGS} || die
}

src_install() {
	dobin bin/alr
	dodoc -r doc/*
}
