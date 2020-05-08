# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

[[ -n "${ATS2_IMPLEMENTATION}" ]] ||
	die "ATS2_IMPLEMENTATION must be set before \"inherit ats2\""

inherit eutils toolchain-funcs
if [[ ${EAPI} < 7 ]]; then
	inherit eapi7-ver
fi

if [[ "${ATS2_IMPLEMENTATION}" == "live-github" ]]; then
	DESCRIPTION="ATS2 Programming Language (ATS2-github version)"
else
	DESCRIPTION="ATS2 Programming Language"
fi
HOMEPAGE="http://www.ats-lang.org"

case "${ATS2_IMPLEMENTATION}" in
	live)
		inherit git-r3 autotools
		EGIT_REPO_URI="https://git.code.sf.net/p/ats2-lang/code"
		DO_AUTOTOOLS=yes
		;;
	live-github)
		inherit git-r3
		EGIT_REPO_URI="https://github.com/githwxi/ATS-Postiats.git"
		DO_AUTOTOOLS=no
		;;
	*)
		SRC_URI_PREFIX="mirror://sourceforge/ats2-lang/ats2-lang/${PN}-postiats-${PV}/ATS2-Postiats-"
		SRC_URI="${SRC_URI_PREFIX}${PV}.tgz"
		DO_AUTOTOOLS=no
		;;
esac

if ver_test -ge 0.3.11; then
	LICENSE="GPL-3 LGPL-3"
else
	LICENSE="GPL-3"
fi

IUSE="smt2 clojure javascript php perl python R scheme"

# FIXME: The dependence on dev-libs/gmp might go away in future
# versions of ATS2. At the time of this writing, there is an
# experimental `ATS-intmin' package that does not use GMP but
# which is not fully featured.
RDEPEND="
	dev-libs/gmp:0
	app-eselect/eselect-ats2
"

# FIXME: Are there any interesting build dependencies? And will we
# need pkg-config at all, once dev-libs/gmp is not needed (if that
# ever happens)?
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

if [[ "${ATS2_IMPLEMENTATION}" == "live-github" ]]; then
	DEPEND+="
		>=dev-lang/ats-0.2.12-r1
		app-arch/tar
		>=sys-devel/autoconf-2.69:*
		sys-devel/automake:*
	"
fi

if ver_test -ge 0.3.13; then
	S="${WORKDIR}/ATS2-Postiats-gmp-${PV}"
else
	S="${WORKDIR}/ATS2-Postiats-${PV}"
fi

EXPORT_FUNCTIONS src_unpack src_prepare src_configure src_compile src_install \
				 pkg_postinst pkg_postrm

installation_prefix() {
	printf "%s" "/usr/ats2/ats2-${ATS2_IMPLEMENTATION}/"
}

ats2_src_unpack() {
	case "${ATS2_IMPLEMENTATION}" in
		live)
			git-r3_fetch "${EGIT_REPO_URI}"
			git-r3_checkout "${EGIT_REPO_URI}" "${S}"
			;;
		live-github)
			git-r3_fetch "${EGIT_REPO_URI}"
			git-r3_checkout "${EGIT_REPO_URI}" "${WORKDIR}/sources"

			pushd "${WORKDIR}/sources" > /dev/null || die

			# Compile from ATS1 sources.
			env PATSHOME=`pwd` make -f Makefile_devl \
				CCOMP="$(tc-getCC)" CC="$(tc-getCC)" ||
				die "\"make -f Makefile_devl\" failed"

			# Create a tar package as if we were doing a release.
			env PATSHOME=`pwd` make -C `pwd`/src CBOOT || die
			env PATSHOME=`pwd` make -C `pwd`/src/CBOOT/prelude || die
			env PATSHOME=`pwd` make -C `pwd`/src/CBOOT/libc || die
			env PATSHOME=`pwd` make -C `pwd`/src/CBOOT/libats || die
			env PATSHOME=`pwd` make -C `pwd`/doc/DISTRIB atspackaging || die
			env PATSHOME=`pwd` make -C `pwd`/doc/DISTRIB atspacktarzvcf || die

			# Unpack that newly created tar package.
			tar -x -C "${WORKDIR}" \
				-f "doc/DISTRIB/ATS2-Postiats-$(get_postiats_version).tgz" ||
				die "unpacking the created tar package failed"

			# Move the unpacked sources into place.
			[[ -e "${S}" ]] ||
				mv "${WORKDIR}/ATS2-Postiats-$(get_postiats_version)" "${S}" ||
				die

			popd > /dev/null || die
			;;
		*)
			default
			;;
	esac
}

ats2_src_prepare() {
	default
	case "${EAPI:-0}" in
		0 | 1 | 2 | 3 | 4) die "EAPI ${EAPI} is not supported." ;;
		5) epatch_user ;;
		*) : ;;
	esac
	if [[ "${DO_AUTOTOOLS}" == "yes" ]]; then
		if [[ ! -f Makefile.am ]]; then
			sed -i -e '/^[ 	]*AM_INIT_AUTOMAKE[ 	]*$/d' configure.ac \
				|| die "sed configure.ac failed"
		fi
		eautoreconf
	fi

	# FIXME: Write our CFLAGS and LDFLAGS to the Makefile.
}

ats2_src_configure() {
	econf --prefix="$(installation_prefix)"
}

compile_atscc2xx() {
	pushd contrib/CATS-atscc2"${1}" > /dev/null || die
	emake -j1 all CCOMP="$(tc-getCC)"
	popd > /dev/null
}

ats2_src_compile() {
	emake -j1 all CCOMP="$(tc-getCC)"
	#	if use patsolve_z3; then
	#		pushd contrib/ATS-extsolve > /dev/null || die
	#		emake -j1 DATS_C CCOMP="$(tc-getCC)"
	#		popd > /dev/null
	#		pushd contrib/ATS-extsolve-z3 > /dev/null || die
	#		emake -j1 all CCOMP="$(tc-getCC)"
	#		popd > /dev/null
	#		mv contrib/ATS-extsolve-z3/patsolve_z3 bin/ || die
	#	fi
	if use smt2; then
		pushd contrib/ATS-extsolve-smt2 > /dev/null || die
		emake -j1 all CCOMP="$(tc-getCC)"
		popd > /dev/null
	fi
	if use clojure || use javascript || use php || use perl || use python || use R || use scheme; then
		pushd contrib/CATS-parsemit > /dev/null || die
		emake -j1 all CCOMP="$(tc-getCC)"
		popd > /dev/null
		use clojure && compile_atscc2xx clj
		use javascript && compile_atscc2xx js
		use php && compile_atscc2xx php
		use perl && compile_atscc2xx pl
		use python && compile_atscc2xx py3
		use R && compile_atscc2xx r34
		use scheme && compile_atscc2xx scm
	fi
}

install_manpages_from_filesdir() {
	# Install manpages from ${FILESDIR} if they are available and not
	# redundant.
	local m
	for m in patscc.1 patsopt.1; do
		if [[ -r "${FILESDIR}/${PVR}/${m}" &&
					! -f "${ED}$(installation_prefix)share/man/man1/${m}" ]]; then
			insinto "$(installation_prefix)share/man/man1/"
			doins "${FILESDIR}/${PVR}/${m}"
		fi
	done
}

get_postiats_version() {
	# Get the current Postiats version from VERSION or from
	# configure.ac, rather than from ${PV}. Using ${PV} will not work
	# for live ebuilds.
	local version=""
	[[ -r VERSION ]] &&
		version=`sed -e '1{s:^[ ]*\([0123456789]\(\.[0123456789]*\)*\)[ ]*$:\1:; p}; d' VERSION`
	[[ x"${version}" = x ]] &&
		version=`sed -e '/^AC_INIT/{s:^AC_INIT(\[.*\],[ ]*\[\([0123456789.]*\)\],.*:\1:; p}; d' configure.ac`
	printf "%s" "${version}"
}

list_installed_files() {
	(cd "${ED}$(installation_prefix)" && find ${1} -type f 2> /dev/null || true)
}

install_contrib_exe() {
	exeinto "$(installation_prefix)"bin
	doexe "${S}"/contrib/"${1}"
}

ats2_src_install() {
	local postiats_version="$(get_postiats_version)"
	local patshome_dir="ats2-postiats-${postiats_version}"
	local patshome="$(installation_prefix)lib/${patshome_dir}"

	# In some versions, ‘make install’ may fail to create the
	# directory for libatslib.a.
	dodir "${patshome}/ccomp/atslib/lib/"

	dodir "$(installation_prefix)"{bin,lib,share/man/man1,etc/env.d}
	default
	dodoc AUTHORS CHANGES*
	dodoc -r RELEASE

	install_manpages_from_filesdir

	#use patsolve_z3 && install_contrib_exe ATS-extsolve-z3/bin/patsolve_z3
	use smt2 && install_contrib_exe ATS-extsolve-smt2/bin/patsolve_smt2
	use clojure && install_contrib_exe CATS-atscc2clj/bin/atscc2clj
	use javascript && install_contrib_exe CATS-atscc2js/bin/atscc2js
	use php && install_contrib_exe CATS-atscc2php/bin/atscc2php
	use perl && install_contrib_exe CATS-atscc2pl/bin/atscc2pl
	use python && install_contrib_exe CATS-atscc2py3/bin/atscc2py3
	use R && install_contrib_exe CATS-atscc2r34/bin/atscc2r34
	use scheme && install_contrib_exe CATS-atscc2scm/bin/atscc2scm

	printf "%s" "PATSHOME=${patshome}" > "${T}/50ats2"
	insinto "$(installation_prefix)etc/env.d"
	doins "${T}/50ats2"

	# Install a script that prints out the value of PATSHOME.
	local patshome_script="patshome-ats2-${ATS2_IMPLEMENTATION}"
	cat > "${T}/${patshome_script}" <<EOF
#!/bin/sh
#
# To use ats2-${ATS2_IMPLEMENTATION} when it is not the default:
#
#   export PATSHOME=\``basename "${T}/${patshome_script}"`\`
#

if test \${#} -eq 0; then
  echo '${patshome}'
elif test \${#} -eq 1 -a "\${1}" = "--help"; then
  echo "Usage: \`basename \${0}\` [OPTION]"
  echo "Print the value to set PATSHOME to if you want to use"
  echo "ats2-${ATS2_IMPLEMENTATION} instead of the system default implementation"
  echo "of ATS2/Postiats."
  echo
  echo "  --help     display this help and exit"
  echo "  --version  output version information and exit"
  echo
  echo "Example:"
  echo
  echo "  export PATSHOME"
  echo "  PATSHOME=\\\``basename "${T}/${patshome_script}"`\\\`"
  echo
elif test \${#} -eq 1 -a "\${1}" = "--version"; then
  echo "ATS2/Postiats implementation ats2-${ATS2_IMPLEMENTATION}"
else
  echo "\`basename \${0}\`: invalid arguments"
  echo "Try '\`basename \${0}\` --help' for more information."
fi
EOF
	exeinto /usr/bin
	doexe "${T}/${patshome_script}"
}

ats2_pkg_postinst() {
    eselect ats2 update --if-unset
}

ats2_pkg_postrm() {
    eselect ats2 update --if-unset
}
