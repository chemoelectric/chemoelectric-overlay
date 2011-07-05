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
IUSE="doc examples emacs libedit mpir readline +static-llvm"

MY_DOCS_V="${PV}"
SRC_URI="${SRC_URI} doc? ( http://pure-lang.googlecode.com/files/pure-docs-${MY_DOCS_V}.tar.gz )"

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

src_compile() {
	default
}

src_install() {
	default

	if use doc ; then
		dodoc pure.txt

		pushd "${WORKDIR}/pure-docs-${MY_DOCS_V}"

		dodoc puredoc.pdf

		local html_dir="${EPREFIX}/usr/share/doc/${PF}/html"
		local docs_dir="${EPREFIX}/usr/$(get_libdir)/${PN}/docs"
		emake install datadir="${html_dir}" DESTDIR="${D}"
		dosym "${html_dir}" "${docs_dir}"

		popd
	fi

	if use examples ; then
		dodoc -r examples
	fi
}
