# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

[[ -n "${ATS2_CONTRIB_VERSION}" ]] ||
	die "ATS2_CONTRIB_VERSION must be set before \"inherit ats2\""

inherit eutils

DESCRIPTION="ATS2 Programming Language contributed packages"
HOMEPAGE="http://www.ats-lang.org"

case "${ATS2_CONTRIB_VERSION}" in
	live)
		inherit git-r3
		EGIT_REPO_URI="https://git.code.sf.net/p/ats2-lang-contrib/code"
		;;
	live-github)
		inherit git-r3
		EGIT_REPO_URI="https://github.com/githwxi/ATS-Postiats-contrib.git"
		;;
	*)
		SRC_URI_PREFIX="mirror://sourceforge/ats2-lang/ats2-lang/ats2-postiats-${PV}/ATS2-Postiats-"
		SRC_URI="${SRC_URI_PREFIX}contrib-${PV}.tgz"
		;;
esac

# FIXME: The licensing is unclear. One repo has an LGPL-3 COPYING
# file, another has an MIT LICENSE file, and tarballs may have no
# notice at all.
LICENSE="LGPL-3 MIT"
IUSE=""

# We do not force the version numbers of the ATS compilation system
# and of the contributed packages to be the same. Upstream has not
# been consistent in matching version numbers. Moreoever, upstream
# even encourages use of a live build for the contributed packages.
RDEPEND="dev-lang/ats2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/ATS2-Postiats-contrib-${PV}"

EXPORT_FUNCTIONS src_unpack src_prepare src_configure \
				 src_compile src_install pkg_postinst

installation_prefix() {
	printf "%s" "/usr/share/ats2-contrib/${ATS2_CONTRIB_VERSION}/"
}

ats2-contrib_src_unpack() {
	case "${ATS2_CONTRIB_VERSION}" in
		live*)
			git-r3_fetch "${EGIT_REPO_URI}"
			git-r3_checkout "${EGIT_REPO_URI}" "${S}"
			;;
		*)
			default
			;;
	esac
}

ats2-contrib_src_prepare() {
	default
	case "${EAPI:-0}" in
		0 | 1 | 2 | 3 | 4) die "EAPI ${EAPI} is not supported." ;;
		5) epatch_user ;;
		*) : ;;
	esac
}

ats2-contrib_src_configure() {
	:
}

ats2-contrib_src_compile() {
	:
}

ats2-contrib_src_install() {
	cd "${S}"

#	local patshomedir="ats2-contrib-${PV}"
#	local patshomereloc="$(installation_prefix)reloc"
	local patshomereloc="$(installation_prefix)"

	default

	dodir "${patshomereloc}"
	insinto "${patshomereloc}"
	doins -r *

	printf "%s" "PATSHOMERELOC=${patshomereloc}" > "${T}/50ats2-contrib"
	insinto "/etc/env.d"
	doins "${T}/50ats2-contrib"
}

ats2-contrib_pkg_postinst()
{
	elog "If you intend to use the ATS2 contributions from the new profile"
	elog "in an already running shell, please remember to do:"
	elog ""
	elog "  . /etc/profile"
}
