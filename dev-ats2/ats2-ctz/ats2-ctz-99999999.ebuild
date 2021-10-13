# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial
inherit autotools

DESCRIPTION="\"Count trailing 0-bits\" for ATS2/Postiats and C"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/ats2-ctz/"
EHG_REPO_URI="http://chemoelectric@hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="+ats2"

BDEPEND="
	ats2? ( dev-lang/ats2:= )
"
RDEPEND=""
DEPEND=""

src_prepare()
{
	default
	eautoreconf
}

src_configure()
{
	econf $(use_with ats2)
}

src_install()
{
	default
	find "${ED}" -name '*.la' -delete || die
}
