# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-r1
inherit sortsmill

DESCRIPTION="Set up the pre-PEP-420 'sortsmill' Python package"
SRC_URI=''

# The license is simply the license of this ebuild.
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_configure() {
	:
}

src_compile() {
	:
}

src_test() {
	:
}

src_install() {
	install_one() {
		# Create a file __init__.py so Python will recognize
		# ‘sortsmill’ as a package.
		local sitedir=`${PYTHON} -c 'import site; print (site.getsitepackages()[0] + "/sortsmill")'`
		dodir "${sitedir}"
		touch "${ED}${sitedir}/__init__.py" || die
	}
	python_foreach_impl install_one
}
