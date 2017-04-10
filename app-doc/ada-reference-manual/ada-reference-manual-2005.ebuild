# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DEBIAN_PKG="${P}_2012.1-2_all.deb"

DESCRIPTION="Ada Reference Manual"
HOMEPAGE="http://www.ada-auth.org/arm.html"
SRC_URI="mirror://debian/pool/main/a/ada-reference-manual/${DEBIAN_PKG}"
LICENSE="ada-reference-manual-2005"

SLOT="2005"

KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/dpkg"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	default
	tar -xzf data.tar.gz || die "\"tar -xzf data.tar.gz\" failed"
}

src_install() {
	local docdir="${D}usr/share/doc/${PF}"

	pushd usr/share/doc-base
	dodoc *
	popd

	pushd "usr/share/doc/${P}"
	gzip -d *.gz
	dodoc *.pdf
	cp -r *-html *.text "${docdir}" || die "recursive copy failed"
	dodoc copyright
	popd

	pushd usr/share/info
	doinfo *.info.gz
	popd
}
