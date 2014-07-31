# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1

DEBIAN_PN="python-defaults"
DEBIAN_PV_BASE="2.7.8"
DEBIAN_PV_PATCH="-1"
DEBIAN_PV="${DEBIAN_PV_BASE}${DEBIAN_PV_PATCH}"

DESCRIPTION="dh_python2 for debhelper"
HOMEPAGE="http://packages.debian.org/sid/python"
SRC_URI="mirror://debian/pool/main/p/${DEBIAN_PN}/${DEBIAN_PN}_${DEBIAN_PV}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-util/debhelper"
DEPEND="${RDEPEND}
	dev-python/docutils
"

S="${WORKDIR}/${DEBIAN_PN}-${DEBIAN_PV_BASE}"

RESTRICT=test

src_compile() {
	${PYTHON} -c 'import compileall; compileall.compile_dir("debpython", force=1)'

	for f in dh_python2 pyclean pycompile; do
		rst2man.py < "${f}.rst" > "${f}.1"
	done
}

src_install() {
	local perllibdir="`perl -MConfig -e 'print $Config{vendorlib}'`/Debian/Debhelper"
	local debpython="$(python_get_sitedir)/debpython"

	dobin dh_python2 pyclean pycompile
	doman dh_python2.1 pyclean.1 pycompile.1
	dodoc debian/changelog README*

	insinto "${perllibdir}/Sequence"
	doins python2.pm

	insinto /usr/share/debhelper/autoscripts/
	doins autoscripts/*

	insinto "${debpython}"
	doins debpython/*

	insinto /usr/share/python/
	doins debian/debian_defaults
}
