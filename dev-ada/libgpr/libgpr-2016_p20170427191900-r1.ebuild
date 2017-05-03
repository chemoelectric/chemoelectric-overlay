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

PATCHES=( "${FILESDIR}/${PF}.patch" )

QA_EXECSTACK="
	usr/*/gpr/relocatable/gpr/libgpr.so*
	usr/*/gpr/static/gpr/libgpr.a:gpr_build_util.o
	usr/*/gpr/static/gpr/libgpr.a:gpr.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-util.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-util-aux.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-proc.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-nmsc.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-knowledge.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-env.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-conf.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-compilation-sync.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-compilation-slave.o
	usr/*/gpr/static/gpr/libgpr.a:gpr-compilation-protocol.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr_build_util.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-util.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-util-aux.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-proc.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-nmsc.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-knowledge.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-env.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-conf.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-compilation-sync.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-compilation-slave.o
	usr/*/gpr/static-pic/gpr/libgpr.a:gpr-compilation-protocol.o
"

src_configure() {
	emake setup prefix="/usr" LIBDIR="$(get_libdir)"
}

src_compile() {
	emake libgpr.build \
		  PROCESSORS="$(makeopts_jobs)" \
		  LIBDIR="$(get_libdir)"
}

src_install() {
	emake libgpr.install prefix="${D}/usr" \
		  PROCESSORS="$(makeopts_jobs)" \
		  LIBDIR="$(get_libdir)"

	# FIXME: Why is this installing an xmlada.gpr file? Can I stop it
	# from doing so?
	rm -f "${D}"/usr/share/gpr/xmlada.gpr

	einstalldocs
}
