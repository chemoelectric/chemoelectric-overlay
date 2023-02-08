# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial
inherit autotools

DESCRIPTION="Extensions to the ATS2 prelude"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/ats2-xprelude/"
EHG_REPO_URI="http://chemoelectric@hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

IUSE="gmp mpfr +timsort +quicksorts"

REQUIRED_USE="
	mpfr? ( gmp )
"

BDEPEND="dev-lang/ats2:="
RDEPEND="
	gmp? ( dev-libs/gmp:= )
	mpfr? ( dev-libs/mpfr:= )
	timsort? ( dev-ats2/ats2-timsort:= )
	quicksorts? ( dev-ats2/ats2-quicksorts:= )
"
DEPEND="${RDEPEND}"

src_prepare()
{
	default
	eautoreconf
}

src_configure()
{
	# Set ATS2_XPRELUDE_DEFAULT_SORTS in your /etc/portage/make.conf, if
	# you wish to choose default sort algorithms other than to use the
	# prelude for sorting.
	econf \
		$(use_with gmp) \
		$(use_with mpfr) \
		$(use_with timsort ats2-timsort) \
		$(use_with quicksorts ats2-quicksorts) \
		--enable-default-sorts="${ATS2_XPRELUDE_DEFAULT_SORTS:-1,1,1,1}"
}

src_install()
{
	default
	find "${ED}" -name '*.la' -delete || die
}
