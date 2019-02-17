# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils multilib

MY_PV=${PV/_p/pl}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Proof assistant written in O'Caml"
HOMEPAGE="https://coq.inria.fr/"
SRC_URI="https://github.com/coq/coq/archive/V${MY_PV}/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk debug +ocamlopt doc"

# FIXME: For >=ocaml-4.06.0, one will need the Num package,
#        which isn’t included in the standard library
#        anymore. (It is the old implementation of
#        arbitrary precision.)
RDEPEND="
	>=dev-lang/ocaml-4.02.3:=[ocamlopt?]
	>=dev-ml/camlp5-6.14:=[ocamlopt?]
	gtk? ( >=dev-ml/lablgtk-2.18.3:=[sourceview,ocamlopt?] )"
DEPEND="${RDEPEND}
	>=dev-ml/findlib-1.4.1
	doc? (
		media-libs/netpbm[png,zlib]
		virtual/latex-base
		dev-tex/hevea
		dev-tex/xcolor
		dev-texlive/texlive-pictures
		dev-texlive/texlive-mathscience
		dev-texlive/texlive-latexextra
		)"

S=${WORKDIR}/${MY_P}

src_configure() {
	ocaml_lib=$(ocamlc -where)
	local myconf=(
		-prefix /usr
		-bindir /usr/bin
		-libdir /usr/$(get_libdir)/coq
		-mandir /usr/share/man
		-coqdocdir /usr/$(get_libdir)/coq/coqdoc
		-docdir /usr/share/doc/${PF}
		-configdir /etc/xdg/${PN}
		-lablgtkdir ${ocaml_lib}/lablgtk2
		)

	#myconf+=( -emacslib /usr/share/emacs/site-lisp )

	use debug && myconf+=( -debug )
	use doc || myconf+=( -with-doc no )

	if use gtk; then
		if use ocamlopt; then
			myconf+=( -coqide opt )
		else
			myconf+=( -coqide byte )
		fi
	else
		myconf+=( -coqide no )
	fi

	use ocamlopt || myconf+=( -byte-only )

	#myconf+=( -usecamlp5 -camlp5dir ${ocaml_lib}/camlp5 )
	myconf+=( -camlp5dir ${ocaml_lib}/camlp5 )

	export CAML_LD_LIBRARY_PATH="${S}/kernel/byterun/"
	./configure ${myconf[@]} || die "configure failed"
}

src_compile() {
	emake STRIP="true" -j1 world VERBOSE=1
}

src_test() {
	emake STRIP="true" check VERBOSE=1
}

src_install() {
	emake STRIP="true" COQINSTALLPREFIX="${D}" install VERBOSE=1
	dodoc README* CREDITS* CHANGES*

	use gtk && make_desktop_entry "coqide" "Coq IDE" "${EPREFIX}/usr/share/coq/coq.png"
}
