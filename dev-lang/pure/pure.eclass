# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pure-lang eutils

DESCRIPTION="A modern-style functional programming language based on term rewriting"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# static-llvm is the default, because currently Pure built from this
# ebuild has trouble finding the shared libraries at run time.
IUSE="doc emacs libedit mpir readline +static-llvm"

SRC_URI="${SRC_URI} doc? ( http://pure-lang.googlecode.com/files/pure-docs-${PV}.tar.gz )"

DEPEND="
    >=sys-devel/llvm-2.9-r2
    emacs? ( virtual/emacs )
    libedit? ( >=dev-libs/libedit-20100424.3.0 )
    mpir? ( >=sci-libs/mpir-2.3.1 )
    !mpir? ( >=dev-libs/gmp-5.0.2 )
    readline? ( >=sys-libs/readline-6.2_p1 )
"
RDEPEND="${DEPEND}"

src_configure() {
	econf --enable-release \
		$(use_with emacs elisp) \
		$(use_with libedit editline) \
		$(use_with mpir) \
		$(use_with readline) \
		$(use_with static-llvm)
}
