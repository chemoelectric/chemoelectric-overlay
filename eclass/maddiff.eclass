# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Compare unformatted text files with numerical content"
HOMEPAGE="https://github.com/quinoacomputing/ndiff"

DOC_PDF=CERN-ACC-NOTE-2013-0005.pdf

SRC_URI="doc? ( https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${DOC_PDF} )"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	S="${WORKDIR}/ndiff-${COMMIT}"
	SRC_URI="
		${SRC_URI}
		https://github.com/quinoacomputing/ndiff/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="doc"

src_install() {
	cmake_src_install
	use doc && dodoc "${DISTDIR}/${DOC_PDF}"
}
