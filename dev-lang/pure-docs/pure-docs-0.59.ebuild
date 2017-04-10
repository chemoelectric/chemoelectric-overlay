# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Documentation for the Pure language"
HOMEPAGE="https://bitbucket.org/purelang/purelang.bitbucket.org"
SRC_URI="https://bitbucket.org/purelang/pure-lang/downloads/${P}.tar.gz"
LICENSE="FDL-1.3+"

SLOT="0"

KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dodoc puredoc.pdf

	local docs_dir="${EPREFIX}/usr/lib/pure/docs"

	local html_dir="${EPREFIX}/usr/share/doc/${PF}/html"
	emake install datadir="${html_dir}" DESTDIR="${D}"
	dosym "${html_dir}" "${docs_dir}"
}
