# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib

DESCRIPTION="Program Database Toolkit"
HOMEPAGE="http://www.cs.uoregon.edu/Research/pdt/home.php"
SRC_URI="http://tau.uoregon.edu/pdt.tgz"
LICENSE="PDT GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# Eliminate QA notice about unstripped binaries.
RESTRICT="strip"

# FIXME: FILL IN THE DEPENDENCIES.
DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	local my_targetbase=usr/$(get_libdir)
	local my_target=${my_targetbase}/${PN}
	local my_image=${WORKDIR}/${PN}

	./configure -targetprefix=/${my_target} -prefix=${my_image} || die "configure"
}

src_install() {
	local my_targetbase=usr/$(get_libdir)
	local my_target=${my_targetbase}/${PN}
	local my_image=${WORKDIR}/${PN}

	if use amd64; then
		archdir=x86_64
	else
		die "Your architecture is not supported by this ebuild."
	fi

	make install || die "make install"
	mkdir -p  ${D}${my_targetbase}
    cp -r ${my_image} ${D}${my_targetbase}

	echo "PATH=\"/${my_target}/${archdir}/bin\"" > 99${PN}
	insinto /etc/env.d
	doins 99${PN}
}
