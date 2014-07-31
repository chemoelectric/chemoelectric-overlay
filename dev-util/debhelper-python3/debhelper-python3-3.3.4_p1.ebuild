# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_1,3_2,3_3} )
PYTHON_REQ_USE=""

inherit eutils python-r1

DEBIAN_PN="python3-defaults"
DEBIAN_PV_BASE="3.3.4"
DEBIAN_PV_PATCH="-1"
DEBIAN_PV="${DEBIAN_PV_BASE}${DEBIAN_PV_PATCH}"

DESCRIPTION="py3clean and py3compile"
HOMEPAGE="http://packages.debian.org/source/sid/python3-defaults"
SRC_URI="mirror://debian/pool/main/p/${DEBIAN_PN}/${DEBIAN_PN}_${DEBIAN_PV}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-util/debhelper
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	dev-python/docutils
"

S="${WORKDIR}/${DEBIAN_PN}-debian"

RESTRICT=test

src_compile() {
	python_export_best EPYTHON

	${EPYTHON} -c 'import compileall; compileall.compile_dir("debpython", force=1)'

	for f in py3clean py3compile; do
		rst2man.py < "${f}.rst" > "${f}.1"
	done
}

src_install() {
	python_export_best PYTHON_SITEDIR

	local perllibdir="`perl -MConfig -e 'print $Config{vendorlib}'`/Debian/Debhelper"
	local debpython="${PYTHON_SITEDIR}/debpython"

	dobin py3clean py3compile
	doman py3clean.1 py3compile.1
	dodoc debian/changelog README*

	insinto "${debpython}"
	doins debpython/*

#	insinto /usr/share/python/
#	doins debian/debian_defaults
}
