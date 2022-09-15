# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

CHICKEN_LIB_VERSION=11

DESCRIPTION="Scheme interpreter and native Scheme to C compiler"
HOMEPAGE="http://www.call-cc.org/"
SRC_URI="https://code.call-cc.org/releases/${PV}/chicken-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="doc mono"

DEPEND=""
RDEPEND="!mono? ( !dev-lang/mono )"

csi_command_name() {
	echo -n chicken-csi
}

csc_command_name() {
	echo -n chicken-csc
}

command_renamings() {
	if use mono; then
		echo -n CSI_PROGRAM=$(csi_command_name) CSC_PROGRAM=$(csc_command_name)
	else
		echo -n ""
	fi
}

src_prepare() {
	default

	# Because chicken's Upstream is in the habit of using variables
	# that portage also uses :( eg. $ARCH and $A
	sed -e "s,A\(\s?=\|)\),chicken&," \
		-i Makefile.cross-linux-mingw defaults.make rules.make || die
	sed -e "s,ARCH,zARCH," \
		-i Makefile.* defaults.make rules.make || die
	sed -e "s,PREFIX)/lib,PREFIX)/$(get_libdir)," \
		-e "s,\$(DATADIR)/doc,\$(SHAREDIR)/doc/${PF}," \
		-i defaults.make || die

	if ! use doc; then
		rm -rf manual || die
		# Without this Makefile tries to re-bootstrap the compiler
		touch build-version.c
	fi
}

src_compile() {
	# See pkg_postinst for an explanation of the program name changes.
	emake -j1 \
		  C_COMPILER="$(tc-getCC)" \
		  PLATFORM=linux \
		  PREFIX=/usr \
		  LINKER_OPTIONS="${LDFLAGS}" \
		  C_COMPILER_OPTIMIZATION_OPTIONS="${CFLAGS}" \
		  HOSTSYSTEM="${CBUILD}" \
		  $(command_renamings)
}

src_test() {
	cd tests
	./runtests.sh || die
}

src_install() {
	emake -j1 \
		  C_COMPILER="$(tc-getCC)" \
		  PLATFORM=linux \
		  PREFIX=/usr \
		  DESTDIR="${D}" \
		  HOSTSYSTEM="${CBUILD}" \
		  LINKER_OPTIONS="${LDFLAGS}" \
		  $(command_renamings) \
		  install

	if use mono; then
		:
	else
		# For compatibility with USE=mono
		dosym csi /usr/bin/$(csi_command_name)
		dosym csc /usr/bin/$(csc_command_name)
	fi

	rm "${D}"/usr/share/doc/${PF}/LICENSE || die

	einstalldocs

	# Let portage track this file (created later)
	touch "${D}"/usr/$(get_libdir)/chicken/${CHICKEN_LIB_VERSION}/modules.db || die
}

pkg_postinst() {
	# Create modules.db file in ${ROOT}
	chicken-install -update-db || die

	if use mono; then
		elog "The following command name changes have been made,"
		elog "so dev-sheme/chicken can co-exist with dev-lang/mono:"
		elog
		elog "    csi -> $(csi_command_name)"
		elog "    csc -> $(csc_command_name)"
		elog
	else
		# FIXME: This message is not very good.
		elog "The following symbolic links have been created,"
		elog "for compatibility with the name changes for USE=mono"
		elog
		elog "    $(csi_command_name) -> csi"
		elog "    $(csc_command_name) -> csc"
		elog
	fi

	elog "Ebuilds should use $(csi_command_name) and $(csc_command_name),"
	elog "rather than csi and csc."
}
