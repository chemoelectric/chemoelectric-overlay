# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

[[ -n "${ATS2_IMPLEMENTATION}" ]] ||
	die "ATS2_IMPLEMENTATION must be set before \"inherit ats2\""

inherit toolchain-funcs
if [[ ${EAPI} < 7 ]]; then
	inherit eutils
	inherit eapi7-ver
fi

DESCRIPTION="ATS2 Programming Language"
HOMEPAGE="http://www.ats-lang.org"

case "${ATS2_IMPLEMENTATION}" in
	live)
		inherit git-r3 autotools
		EGIT_REPO_URI="https://git.code.sf.net/p/ats2-lang/code"
		DO_AUTOTOOLS=yes
		;;
	*)
		SRC_URI_PREFIX="mirror://sourceforge/ats2-lang/ats2-lang/${PN}-postiats-${PV}/ATS2-Postiats-"
		SRC_URI="
			gmp? ( ${SRC_URI_PREFIX}gmp-${PV}.tgz )
			!gmp? ( ${SRC_URI_PREFIX}int-${PV}.tgz )
			contrib? ( ${SRC_URI_PREFIX}contrib-${PV}.tgz )
		"
		DO_AUTOTOOLS=no
		IUSE="+contrib"
		;;
esac

if [[ -n "${ATS2_MANPAGE_SRC_URI}" ]]; then
	SRC_URI="${SRC_URI} ${ATS2_MANPAGE_SRC_URI}"
fi

LICENSE="GPL-3 LGPL-3 MIT"

IUSE="${IUSE} gmp smt2 clojure javascript php perl python R scheme"

RDEPEND="
	dev-libs/boehm-gc:=
	gmp? ( dev-libs/gmp:= )
	smt2? ( dev-libs/json-c:= )
"

# FIXME: Are there any interesting build dependencies? And will we
# need pkg-config at all, once dev-libs/gmp is not needed (if that
# ever happens)?
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

S="${WORKDIR}/build"

export PATSHOME="${S}"
export PATH="${PATSHOME}/bin${PATH:+:}${PATH:-}"
unset PATSHOMERELOC

EXPORT_FUNCTIONS pkg_pretend src_unpack src_prepare src_configure \
				 src_compile src_install pkg_postinst

int_or_gmp() {
	if use gmp; then
		echo gmp
	else
		echo int
	fi
}

installation_prefix() {
	printf "%s" "/usr/"
}

ats2_pkg_pretend() {
	case "${ATS2_IMPLEMENTATION}" in
		live)
			use gmp || die "live ebuild requires USE=gmp"
			;;
	esac
}

ats2_src_unpack() {
	case "${ATS2_IMPLEMENTATION}" in
		live)
			git-r3_fetch "${EGIT_REPO_URI}"
			git-r3_checkout "${EGIT_REPO_URI}" "${S}"
			;;
		*)
			default
			ln -s ATS2-Postiats-"$(int_or_gmp)"-"${PV}" build || die
			if use contrib; then
				mv ATS2-Postiats-contrib-"${PV}"/contrib/* build/contrib || die
				rmdir ATS2-Postiats-contrib-"${PV}"/contrib || die
				rmdir ATS2-Postiats-contrib-"${PV}" || die
			fi
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
	emake -j1 all CCOMP="$(tc-getCC)" GCFLAG=-D_ATS_GCBDW
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

install_manpages_from_debian() {
	# Install Debian’s manpages if they are available and not redundant.
	local debian="${WORKDIR}/debian/"
	local inst1="$(installation_prefix)share/man/man1/"
	local m
	for m in myatscc.1 patscc.1 patsopt.1; do
		if [[ -r "${debian}${m}" ]]; then
			if [[ ! -f "${ED}${inst1}${m}" ]]; then
				insinto "${inst1}"
				doins "${debian}${m}"
			fi
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

install_contrib_exe() {
	exeinto "$(installation_prefix)"bin
	doexe "${S}"/contrib/"${1}"
}

ats2_src_install() {
	local postiats_version="$(get_postiats_version)"
	local patshome_dir="ats2-postiats-${postiats_version}"

	# FIXME: Get things installed where we might prefer, such as in
	#        $(get_libdir) instead of in lib.
	local patshome="$(installation_prefix)lib/${patshome_dir}"

	# In some versions, ‘make install’ may fail to create the
	# directory for libatslib.a.
	dodir "${patshome}/ccomp/atslib/lib/"

	dodir "$(installation_prefix)"{bin,lib,share/man/man1,etc/env.d}
	default
	dodoc AUTHORS CHANGES*
	dodoc -r RELEASE

	install_manpages_from_debian

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
	insinto "/etc/env.d"
	doins "${T}/50ats2"
}

ats2_pkg_postinst()
{
	elog "If you intend to use the ATS2 from the new profile in an already"
	elog "running shell, please remember to do:"
	elog ""
	elog "  . /etc/profile"
}
