# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Revised5 Report on the Algorithmic Language Scheme"
HOMEPAGE="http://www.schemers.org/Documents/Standards/R5RS/"
SRC_URI="
	${HOMEPAGE}/r5rs.dvi
	${HOMEPAGE}/r5rs.ps
	${HOMEPAGE}/r5rs.pdf
	${HOMEPAGE}/r5rs-html.tar.gz
"

LICENSE="FIXME"

SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_prepare() {
	default
	mv HTML html || die "mv failed"
}

src_install() {
	dodoc "${DISTDIR}"/r5rs.{dvi,ps,pdf}
	dodoc -r html
}
