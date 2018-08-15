# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="McCabe-style function complexity and line counting for C and C++"
HOMEPAGE="https://packages.debian.org/wheezy/pmccabe"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i -e 's/ -o pmccabe / $(LDFLAGS) -o pmccabe /' Makefile \
		|| die "src_prepare failed"
	eapply_user
}

src_compile() {
	emake CC=$(tc-getCC)
}
