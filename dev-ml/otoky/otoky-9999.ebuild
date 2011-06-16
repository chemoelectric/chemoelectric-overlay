# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://github.com/jaked/otoky.git"

inherit eutils git findlib

DESCRIPTION="OCaml bindings for Tokyo {Cabinet, Tyrant}"

HOMEPAGE="https://github.com/jaked/otoky"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE="tokyotyrant"

DEPEND="
    >=dev-db/tokyocabinet-1.4.47
    tokyotyrant? ( >=net-misc/tokyotyrant-1.1.41 )
"
RDEPEND="${DEPEND}"

src_configure() {
	if use tokyotyrant ; then
		./configure -enable-tt || die "configure failed"
	else
		./configure -disable-tt || die "configure failed"
	fi
}

src_install() {
    findlib_src_install
}
