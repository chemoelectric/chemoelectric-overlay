# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools
inherit mercurial
inherit multilib-minimal

DESCRIPTION="A D-language wrapper library for libxml2"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/libxml2-d"
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/libxml2-d"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="
	dev-util/indent
	dev-util/unifdef
	virtual/pkgconfig
"
RDEPEND="
	dev-libs/libxml2:2=[${MULTILIB_USEDEP}]
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	# Out-of-source builds.
	ECONF_SOURCE="${S}" econf
}

multilib_src_install_all() {
	find "${ED}" -name '*.la' -delete || die
}
