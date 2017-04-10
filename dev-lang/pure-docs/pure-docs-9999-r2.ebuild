# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-2

DESCRIPTION="Documentation for the Pure language"
HOMEPAGE="http://puredocs.bitbucket.org"
EGIT_REPO_URI="https://bitbucket.org/puredocs/puredocs.bitbucket.org.git"
LICENSE="FDL-1.3+"

SLOT="0"

KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dodoc puredoc.pdf

	# FIXME: Should this be the the architecture-dependent libdir? Is
	# this messed up throughout my ebuilds?
	local docs_dir="${EPREFIX}/usr/lib/pure/docs"

	local html_dir="${EPREFIX}/usr/share/doc/${PF}/html"
	emake install datadir="${html_dir}" DESTDIR="${D}"
	dosym "${html_dir}" "${docs_dir}"
}
