# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
#SUPPORT_PYTHON_ABIS="1"
PYTHON_COMPAT=( python{2_{6,7},3_{1,2,3}} )

inherit distutils-r1 git-2

DESCRIPTION="An interface to libmagic"
HOMEPAGE="https://bitbucket.org/chemoelectric/pyfilemagic"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	>=dev-lang/python-2.6.4:=
	>=sys-apps/file-5.03
	"
DEPEND="
	${RDEPEND}
	"

S="${WORKDIR}/${PN}"

src_prepare() {
	cp setup-no_cython.py setup.py || die
	distutils-r1_src_prepare
}
