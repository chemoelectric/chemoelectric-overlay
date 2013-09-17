# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mercurial

DESCRIPTION="Documentation for the Pure language"
HOMEPAGE="https://bitbucket.org/purelang/purelang.bitbucket.org"
EHG_REPO_URI="${HOMEPAGE}"
LICENSE="FDL-1.3+"

SLOT="0"

KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	(
		cd docs
		dodoc puredoc.pdf
		local html_dir="${EPREFIX}/usr/share/doc/${PF}/html"
		local docs_dir="${EPREFIX}/usr/$(get_libdir)/${PN}/docs"
		emake install datadir="${html_dir}" DESTDIR="${D}"
		dosym "${html_dir}" "${docs_dir}"
	)

	# The PQR is not included in releases and so should not be
	# included here, as it was in pure-docs-9999.ebuild.
	#
	# FIXME: We could have a PQR ebuild of its own, though.
	#
	#dodoc quickref/pure-quickref.pdf
}
