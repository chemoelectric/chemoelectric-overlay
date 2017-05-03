# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs multiprocessing pax-utils

DESCRIPTION="An advanced build system for the construction of multi-language systems"
HOMEPAGE="http://libre.adacore.com"

MY_DOWNLOADS="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads"
MY_ADACORE_SRC="${PN}-gpl-${PV/_*/}-src"

SRC_URI="
	${MY_DOWNLOADS}/${P}.tar.xz
	${MY_DOWNLOADS}/xmlada-${PV}.tar.xz
	doc? (
		http://mirrors.cdn.adacore.com/art/57399662c7a447658e0affa8 ->
			${MY_ADACORE_SRC}.tar.gz
	)
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND=""
DEPEND="
	${RDEPEND}
	virtual/ada:*
	doc? ( dev-python/sphinx:* )
"

QA_EXECSTACK="
	usr/bin/gprbuild
	usr/bin/gprconfig
	usr/bin/gprclean
	usr/bin/gprinstall
	usr/bin/gprname
	usr/bin/gprls
	usr/libexec/gprbuild/gprlib
	usr/libexec/gprbuild/gprbind
"

#####################################################################
# The code used below is adapted from dev-ada/gprbuild-2016::gentoo
# and avoids the need to have gprbuild and xmlada already installed.
#####################################################################

bin_progs1="gprbuild gprconfig gprclean gprinstall gprname gprls"
# FIXME: We do not build gprslave. Sorry.
#bin_progs2="gprslave"
bin_progs2=""
bin_progs="${bin_progs1} ${bin_progs2}"
lib_progs="gprlib gprbind"

src_configure() {
	:
}

src_compile() {
	local xmlada_src="${WORKDIR}/xmlada-${PV}"
	incflags="-Isrc -Igpr/src -I${xmlada_src}/sax -I${xmlada_src}/dom \
			-I${xmlada_src}/schema -I${xmlada_src}/unicode \
			-I${xmlada_src}/input_sources"
	$(tc-getCC) -c ${CFLAGS} gpr/src/gpr_imports.c -o gpr_imports.o || die
	for bin in ${bin_progs1}; do
		${GNATMAKE:-gnatmake} -j"$(makeopts_jobs)" \
							  ${incflags} ${GNATMAKEFLAGS} \
							  ${bin}-main -o ${bin} \
							  -largs gpr_imports.o || die
	done
	[[ -n "${bin_progs2}" ]] && {
		for bin in ${bin_progs2}; do
			${GNATMAKE:-gnatmake} -j"$(makeopts_jobs)" \
								  ${incflags} ${GNATMAKEFLAGS} \
								  ${bin} -o ${bin} \
								  -largs gpr_imports.o || die
		done
	}
	for lib in ${lib_progs}; do
		${GNATMAKE:-gnatmake} -j"$(makeopts_jobs)" \
							  ${incflags} ${lib} ${GNATMAKEFLAGS} \
							  -largs gpr_imports.o || die
	done

	use doc && {
		emake -C doc info
		emake -C doc html
		emake -C doc txt
	}
}

src_install() {
	dobin ${bin_progs}
	exeinto /usr/libexec/gprbuild
	doexe ${lib_progs}
	insinto /usr/share
	doins -r share/gprconfig
	insinto /usr/share/gpr
	doins share/_default.gpr

	pax-mark m "${D}"/usr/bin/gprbuild
	pax-mark m "${D}"/usr/bin/gprconfig
	pax-mark m "${D}"/usr/bin/gprclean
	pax-mark m "${D}"/usr/bin/gprinstall
	pax-mark m "${D}"/usr/bin/gprname
	pax-mark m "${D}"/usr/bin/gprls
	pax-mark m "${D}"/usr/libexec/gprbuild/gprlib
	pax-mark m "${D}"/usr/libexec/gprbuild/gprbind

	dodoc README*

	use doc && {
		pushd doc
		doinfo info/*.info
		dodoc -r html
		dodoc txt/*.txt
		popd
		pushd "${WORKDIR}"/"${MY_ADACORE_SRC}"
		dodir /usr/share/doc/"${PF}"/"${MY_ADACORE_SRC}"
		cp README* CHANGES* features-* known-problems-* \
		   "${D}"/usr/share/doc/"${PF}"/"${MY_ADACORE_SRC}" || die
		popd
	}

	use examples && dodoc -r examples
}
