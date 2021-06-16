# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial
inherit autotools

DESCRIPTION="Floating-point types and mathematical functions for ATS2/Postiats"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/ats2-floattypes/"
EHG_REPO_URI="http://chemoelectric@hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

BDEPEND="
	dev-lang/ats2:=
	sys-devel/m4:*
"
RDEPEND=""
DEPEND=""

src_prepare()
{
	default
	eautoreconf
}
