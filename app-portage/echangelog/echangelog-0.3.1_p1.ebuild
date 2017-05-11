# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Support only the sole stable version of Python, so that this ebuild
# does not constantly go out of date. (I have no intention of further
# explaining that ‘stable’ here means ‘not subject to arbitrary
# changes in Python or to a decision of Gentoo to drop a version’.)
#
#PYTHON_COMPAT=( python{2_7,3_4,3_5} )
PYTHON_COMPAT=( python2_7 )

PYTHON_REQ_USE="xml"

inherit eutils python-r1

TAR_NAME="gentoolkit-dev-${PV/_p*/}"

DESCRIPTION="The echangelog developer script for Gentoo"
HOMEPAGE="https://bitbucket.org/chemoelectric/chemoelectric-overlay/"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${TAR_NAME}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

# The test has not been ported to this ebuild.
#IUSE="test"
IUSE=""
RESTRICT="test"

RDEPEND="${DEPEND}"

CDEPEND="
	sys-apps/portage[${PYTHON_USEDEP}]
	dev-lang/perl
	sys-apps/diffutils
"
DEPEND="
	${PYTHON_DEPS}
	!app-portage/gentoolkit-dev:*
"
# test? ( ${CDEPEND} )
RDEPEND="
	${PYTHON_DEPS}
	${CDEPEND}
"

S="${WORKDIR}/${TAR_NAME}/src/${PN}"

src_prepare() {
	eapply -p3 "${FILESDIR}/${TAR_NAME}"-{portdir,id,Makefile}.patch
	eapply_user

	if [[ -n ${EPREFIX} ]] ; then
		ebegin "Fixing shebangs"
		sed -i \
			-e "1s:\(\(/usr\)\?/bin/\):${EPREFIX}\1:" \
			echangelog || die
		eend $?
	fi
}

src_test() {
	# echangelog test is not able to run as root
	# the EUID check may not work for everybody
	if [[ ${EUID} -ne 0 ]]; then
		python_foreach_impl emake test
	else
		ewarn "test skipped, please re-run as non-root if you wish to test ${PN}"
	fi
}

src_install() {
	emake DESTDIR="${D}" \
		  PREFIX="${EPREFIX}/usr" \
		  DOCDIR="${D}/${EPREFIX}/usr/share/doc/${PF}" \
		  install
}
