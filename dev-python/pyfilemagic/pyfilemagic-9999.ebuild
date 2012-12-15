# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils git

DESCRIPTION="An interface to libmagic"
HOMEPAGE="https://bitbucket.org/chemoelectric/pyfilemagic"
SRC_URI=""
EGIT_REPO_URI="https://chemoelectric@bitbucket.org/chemoelectric/pyfilemagic.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-lang/python-2.6.4
	>=sys-apps/file-5.03
	"
DEPEND="
	${RDEPEND}
	"

S="${WORKDIR}/${PN}"

src_compile() {
	cd "${S}"
	cp setup-no_cython.py setup.py
	distutils_src_compile || die "distutils_src_compile failed"
}
