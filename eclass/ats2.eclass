# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

###
### FIXME: This package installs stuff in /usr/lib that, ideally,
### ought to go elsewhere.
###

###
### FIXME: PERHAPS SUPPORT SLOTS (including a separate slot for live
### ebuild, and an eselect choice)
###

inherit eutils toolchain-funcs elisp-common

DESCRIPTION="ATS2 Programming Language"
HOMEPAGE="http://www.ats-lang.org"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3 autotools
	MAIN_EGIT_REPO_URI="git://git.code.sf.net/p/ats2-lang/code"
	CONTRIB_EGIT_REPO_URI="git://git.code.sf.net/p/ats2-lang-contrib/code"
	DO_AUTOTOOLS=yes
else
	SRC_URI_PREFIX="mirror://sourceforge/ats2-lang/ats2-lang/${PN}-postiats-${PV}/ATS2-Postiats-"
	SRC_URI="
		${SRC_URI_PREFIX}${PV}.tgz
		contrib? ( ${SRC_URI_PREFIX}include-${PV}.tgz )
	"
	DO_AUTOTOOLS=no
fi

LICENSE="GPL-3"
IUSE="+contrib emacs"

# FIXME: The dependence on dev-libs/gmp will go away in future
# versions of ATS2.
RDEPEND="dev-libs/gmp:0"

# FIXME: Are there any interesting build dependencies? And will we
# need pkg-config at all, once dev-libs/gmp is not needed?
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	emacs? ( virtual/emacs )
"

S="${WORKDIR}/ATS2-Postiats-${PV}"
S_INCLUDE="${WORKDIR}/ATS2-Postiats-include-${PV}"

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install

ats2_src_unpack() {
	if [[ ${PV} == "9999" ]]; then
		git-r3_fetch "${MAIN_EGIT_REPO_URI}"
		git-r3_checkout "${MAIN_EGIT_REPO_URI}" "${S}"
		use contrib && {
			git-r3_fetch "${CONTRIB_EGIT_REPO_URI}"
			git-r3_checkout "${CONTRIB_EGIT_REPO_URI}" "${S_INCLUDE}"
		}
	else
		default
	fi
}

ats2_src_prepare() {
	default
	epatch_user
	[[ "${DO_AUTOTOOLS}" == "yes" ]] && {
		[[ ! -f Makefile.am ]] && {
			sed -i -e '/^[ 	]*AM_INIT_AUTOMAKE[ 	]*$/d' configure.ac \
				|| die "sed configure.ac failed"
		}
		eautoreconf
	}

	# FIXME: Write our CFLAGS and LDFLAGS to the Makefile.
}

ats2_src_compile() {
	emake -j1 all CCOMP="$(tc-getCC)"

	if use emacs; then
		einfo "Compiling emacs lisp files"
		elisp-compile "utils/emacs/"*.el || die "elisp-compile failed"
	fi
}

ats2_src_install() {
	# Get the current Postiats version from VERSION or from
	# configure.ac, rather than from ${PV}. Using ${PV} will not work
	# for live ebuilds.
	local my_pv=""
	[[ -r VERSION ]] &&
		my_pv=`sed -e '1{s:^[ ]*\([0123456789]\(\.[0123456789]*\)*\)[ ]*$:\1:; p}; d' VERSION`
	[[ x"${my_pv}" = x ]] &&
		my_pv=`sed -e '/^AC_INIT/{s:^AC_INIT(\[.*\],[ ]*\[\([0123456789.]*\)\],.*:\1:; p}; d' configure.ac`

	local patshome="/usr/lib/${PN}-postiats-${my_pv}"

	default

	use contrib && {
		pushd "${S_INCLUDE}"
		for d in *; do
			[[ -d "${d}" ]] && {
				(tar -c -f - "${d}" | tar -C "${D}${patshome}" -x -f -) \
					|| die "failure while trying to copy ${d} into place"
			}
		done
		popd
	}

	{
		echo "PATSHOME=${patshome}"
		use contrib && echo "PATSHOMERELOC=${patshome}"
	} \
		> "${T}/50ats2" || die "failed to make 50ats2"
	doenvd "${T}/50ats2"

	if use emacs; then
		pushd "utils/emacs" > /dev/null
		elisp-install "${PN}" *.el *.elc || die "elisp-install failed"
		cat > "50${PN}-gentoo.el" <<EOF
;; site-init for dev-lang/${PN}
(add-to-list 'load-path "@SITELISP@")
EOF
		elisp-site-file-install "50${PN}-gentoo.el"
		popd > /dev/null
	fi
}
