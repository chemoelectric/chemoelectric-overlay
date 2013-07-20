# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit elisp-common elisp

ARCHIVE_PN="emacs-goodies-el"

DESCRIPTION="Emacs helpers specific to Debian users"
HOMEPAGE="http://packages.debian.org/search?keywords=debian-el"
SRC_URI="mirror://debian/pool/main/e/${ARCHIVE_PN}/${ARCHIVE_PN}_${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/quilt
"

MY_TOPDIR="${WORKDIR}/${ARCHIVE_PN}-${PV}"
S="${MY_TOPDIR}/elisp/${PN}"

ELISP_TEXINFO="debian-el.texi"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	(cd "${MY_TOPDIR}" &&
		QUILT_PATCHES=debian/patches \
			quilt --quiltrc /dev/null push -a) || die "quilt failed"
	/bin/sh debian-el-loaddefs.make || die "debian-el-loaddefs.make failed"
	elisp_src_prepare
	sed -i -e 's|^\(@setfilename info/debian-el[ 	]*$\)|@c \1|' \
		debian-el.texi || die "sed failed"
}

src_compile() {
	/bin/sh debian-el-loaddefs.make || die "debian-el-loaddefs.make failed"
	elisp-compile apt-sources.el debian-bug.el debian-el-loaddefs.el \
		apt-utils.el debian-el.el deb-view.el preseed.el \
		|| die "elisp-compile failed"
	[[ -n ${ELISP_TEXINFO} ]] && \
		(makeinfo ${ELISP_TEXINFO} || die "makeinfo failed")
}

src_install() {
	elisp_src_install
	dodoc "${MY_TOPDIR}"/debian/{{,debian-el.}README.Debian,debian-el.copyright}
}
