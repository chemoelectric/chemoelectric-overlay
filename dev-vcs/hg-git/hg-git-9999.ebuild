# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python2_7 python3_6 python3_7 python3_8 )

inherit mercurial distutils-r1

DESCRIPTION="push to and pull from a Git repository using Mercurial"
HOMEPAGE="https://hg-git.github.io https://foss.heptapod.net/mercurial/hg-git"
EHG_REPO_URI="https://foss.heptapod.net/mercurial/hg-git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-vcs/mercurial-5.4[${PYTHON_USEDEP}]
	>=dev-python/dulwich-0.19.15[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
