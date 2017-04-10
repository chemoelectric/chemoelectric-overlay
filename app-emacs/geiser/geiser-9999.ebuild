# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
NEED_EMACS=23

inherit git-2 elisp

DESCRIPTION="Emacs modes for Scheme interaction"
HOMEPAGE="http://www.nongnu.org/geiser/"
EGIT_REPO_URI="git://git.sv.gnu.org/geiser.git"
SITEFILE="50${PN}-gentoo.el"

LICENSE="BSD"
IUSE=""

KEYWORDS=""
SLOT="0"

DEPEND=""
RDEPEND=""

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	./autogen.sh || die "autogen.sh failed"
}

src_configure() {
	econf --with-lispdir="${SITELISP}/${PN}"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	cp "${FILESDIR}/${SITEFILE}" . || die "failed to copy ${FILESDIR}/${SITEFILE}"
	elisp-site-file-install "${SITEFILE}" || die "failed to install ${SITEFILE}"
	dodoc AUTHORS NEWS README THANKS
}
