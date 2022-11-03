# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial
inherit autotools

DESCRIPTION="Timsort for ATS2/Postiats and C, written in ATS2"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/ats2-timsort/"
EHG_REPO_URI="http://chemoelectric@hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

BDEPEND="
	dev-lang/ats2:=
"
RDEPEND=""
DEPEND=""

src_prepare()
{
	default
	eautoreconf
}

src_install()
{
	default
	find "${ED}" -name '*.la' -delete || die
}
