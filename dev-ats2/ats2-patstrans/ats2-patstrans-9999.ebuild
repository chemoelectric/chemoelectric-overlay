# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial autotools
DESCRIPTION="ATS2 Patstrans"
HOMEPAGE="https://ats2libraries.sourceforge.io"
EHG_REPO_URI="http://hg.code.sf.net/p/ats2libraries/${PN}"
LICENSE="GPL-3+"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="
	>=dev-lang/ats2-0.3.11
"

src_prepare() {
	default
	eautoreconf
}
