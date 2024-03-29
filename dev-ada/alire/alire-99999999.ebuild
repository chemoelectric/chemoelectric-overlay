# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ADA_COMPAT=( gnat_2021 gcc_12 )

inherit git-r3
inherit ada
inherit multiprocessing

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
	ALIRE_OS=linux \
		gprbuild -j$(makeopts_jobs) -P alr_env \
		-p -v -cargs:Ada ${ADAFLAGS} -cargs:C ${CFLAGS} || die
}

src_install() {
	dobin bin/alr
	dodoc -r doc/*
}
