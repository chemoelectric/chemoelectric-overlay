# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Compare unformatted text files with numerical content"
HOMEPAGE="https://github.com/quinoacomputing/ndiff"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	S="${WORKDIR}/ndiff-${COMMIT}"
	SRC_URI="https://github.com/quinoacomputing/ndiff/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
