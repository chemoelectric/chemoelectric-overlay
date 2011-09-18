# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils subversion

DESCRIPTION="Tool for creating Gentoo ebuilds for Python packages by querying PyPI (The Cheese Shop)"
HOMEPAGE="http://tools.assembla.com/g-pypi/"
ESVN_REPO_URI="http://g-pypi.googlecode.com/svn/trunk/"
LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND="dev-python/pygments
	dev-python/setuptools
	dev-python/cheetah
	dev-python/configobj"

src_install() {
	touch MANIFEST.in
	echo "include g_pypi/ebuild.tmpl" >> MANIFEST.in
	distutils_src_install
}
