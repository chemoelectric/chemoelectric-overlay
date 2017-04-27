# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="An advanced build system for the construction of multi-language systems"
HOMEPAGE="https://github.com/AdaCore/gprbuild"

EGIT_REPO_URI="https://github.com/AdaCore/${PN}.git"
XMLADA_REPO_URI="https://github.com/AdaCore/xmlada.git"

LICENSE="GPL-3+ gcc-runtime-library-exception-3.1"
SLOT="0"
KEYWORDS=""
IUSE="first-time-bootstrap doc examples libgpr"

RDEPEND=""
DEPEND="
	virtual/ada:*
	${RDEPEND}
	!first-time-bootstrap? (
		${CATEGORY}/${PN}:*
		dev-ada/xmlada:*
		doc? ( dev-python/sphinx:* )
	)
"

# FIXME: Deal with the QA notices. I think these might just be
# annoyingly loud warnings about there being trampolines in the
# compiled code. It’s not my fault GNAT implements nested functions as
# stack-frame trampolines, nor do I care very much, although they
# probably should do it differently.

src_unpack() {
	git-r3_fetch
	git-r3_checkout
	if use first-time-bootstrap; then
		git-r3_fetch "${XMLADA_REPO_URI}"
		git-r3_checkout "${XMLADA_REPO_URI}" "${WORKDIR}/xmlada"
	fi
}

src_prepare() {
	default

	if use first-time-bootstrap; then
		:
	else
		# Building of gprslave does not work at the moment.
		# (2017 Apr 14)
		sed -i 's/"gprslave.adb",//' gprbuild.gpr || die

		# -Es is not supported in GNU GCC 5.4.0 gnatbind, but -E is.
		sed -i 's/"-Es",/"-E",/' gprbuild.gpr || die
		## Or, if you also want shared bindings with libgnat.
		#sed -i 's/"-Es", "-static"/"-E", "-shared"/' gprbuild.gpr || die

		## Dynamic-link gprbuild with xmlada. You might end up
		## having to re-bootstrap, though, if anything changes
		## in the xmlada installation.
		#sed -i 's/-XXMLADA_BUILD=static/-XXMLADA_BUILD=relocatable/' Makefile ||
		#	die
	fi
}

src_configure() {
	if use first-time-bootstrap; then
		:
	else
		emake setup prefix=/usr
	fi
}

src_compile() {
	if use first-time-bootstrap; then
		mkdir "${WORKDIR}/staging" || die
		env DESTDIR="${WORKDIR}/staging" \
			CFLAGS="" bin="" lib="" \
			sh ./bootstrap.sh \
			--with-xmlada="../xmlada" \
			--prefix="/usr" \
			--bindir="/usr/bin" \
			--libexecdir="/usr/libexec" \
			--datarootdir="/usr/share" || die
	else
		emake all
		use libgpr && emake libgpr.build.static
		use libgpr && emake libgpr.build.static-pic
		use libgpr && emake libgpr.build.shared
		use doc && {
			emake -C doc info
			emake -C doc html
			emake -C doc txt
		}
	fi
}

src_install() {
	if use first-time-bootstrap; then
		cp -R "${WORKDIR}/staging/usr/"* "${D}" || die
	else
		emake install prefix="${D}/usr"
		use libgpr && emake libgpr.install.static prefix="${D}/usr"
		use libgpr && emake libgpr.install.static-pic prefix="${D}/usr"
		use libgpr && emake libgpr.install.shared prefix="${D}/usr"
		einstalldocs
		local pn_doc="${D}/usr/share/doc/${PN}"
		use doc && {
			doinfo "${pn_doc}"/info/*.info
			mv "${pn_doc}"/{html,txt/*.txt} "${D}/usr/share/doc/${PF}/" || die
		}
		rm -f -R "${pn_doc}" || die
		use examples && dodoc -r examples
	fi
}
