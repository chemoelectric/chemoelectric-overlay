# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#SUPPORT_PYTHON_ABIS="1"
PYTHON_COMPAT=( python{2_7,3_{6,7,8}} )
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1 git-r3

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

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	default
	cp setup-no_cython.py setup.py || die
	distutils-r1_src_prepare
}
