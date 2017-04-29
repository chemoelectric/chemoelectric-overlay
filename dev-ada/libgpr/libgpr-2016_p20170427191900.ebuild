# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing

# FIXME: Make a patch to gprbuild-2016, rather than take a snapshot of
# the SCM repository.

MY_PV="${PN}-gpl-${PV}-src"
MY_XMLADA_PV="xmlada-gpl-${PV}-src"

DESCRIPTION="The gprbuild library"
HOMEPAGE="http://libre.adacore.com"

SRC_URI_PREFIX="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads"
SRC_URI="${SRC_URI_PREFIX}/gprbuild-${PV}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/ada:*"
DEPEND="
	${RDEPEND}
	>=dev-ada/xmlada-2016_p20170427191900:*
	>=dev-ada/gprbuild-2016_p20170427191900:*
"

S="${WORKDIR}/gprbuild-${PV}"

src_configure() {
	emake setup prefix=/usr
}

src_compile() {
	emake -j1 libgpr.build PROCESSORS="$(makeopts_jobs)"
}

src_install() {
	emake -j1 libgpr.install prefix="${D}/usr" PROCESSORS="$(makeopts_jobs)"
	einstalldocs
}
