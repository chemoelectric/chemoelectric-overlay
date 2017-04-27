# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3
inherit toolchain-funcs multiprocessing

MY_PV="${PN}-gpl-${PV}-src"
MY_XMLADA_PV="xmlada-gpl-${PV}-src"

DESCRIPTION="An advanced build system for the construction of multi-language systems"
HOMEPAGE="http://libre.adacore.com"
EGIT_REPO_URI="https://github.com/AdaCore/${PN}.git"
XMLADA_REPO_URI="https://github.com/AdaCore/xmlada.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="doc examples"

RDEPEND=""
DEPEND="
	${RDEPEND}
	virtual/ada:*
	doc? ( dev-python/sphinx:* )
"

# FIXME: Support libgpr, though actually I think it makes more sense
# to have libgpr as a separate ebuild.

# FIXME: Deal with the QA notices. I think these might just be
# annoyingly loud warnings about there being trampolines in the
# compiled code. It’s not my fault GNAT implements nested functions as
# stack-frame trampolines, nor do I care very much, although they
# probably should do it differently.

# The code used below is adapted from dev-ada/gprbuild-2016::gentoo
# and avoids needing gprbuild, and an installed xmlada, to build
# gprbuild.

bin_progs1="gprbuild gprconfig gprclean gprinstall gprname gprls"
#bin_progs2="gprslave"
bin_progs2=""
bin_progs="${bin_progs1} ${bin_progs2}"
lib_progs="gprlib gprbind"

src_unpack() {
	git-r3_fetch
	git-r3_checkout
	git-r3_fetch "${XMLADA_REPO_URI}"
	git-r3_checkout "${XMLADA_REPO_URI}" "${WORKDIR}/xmlada"
}

src_configure() {
	:
}

src_compile() {
	local xmlada_src="${WORKDIR}/xmlada"
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

	dodoc README*

	use doc && {
		pushd doc
		doinfo info/*.info
		dodoc -r html
		dodoc txt/*.txt
		popd
	}

	use examples && dodoc -r examples
}
