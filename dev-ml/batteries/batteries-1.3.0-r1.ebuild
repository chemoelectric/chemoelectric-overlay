# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit multilib eutils

DESCRIPTION="Batteries is just the OCaml development platform"
HOMEPAGE="http://batteries.forge.ocamlcore.org/"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/560/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt doc"

RDEPEND=">=dev-lang/ocaml-3.12.1
	ocamlopt? ( >=dev-lang/ocaml-3.12.1[ocamlopt] )
	>=dev-ml/camomile-0.8.2
	ocamlopt? ( >=dev-ml/camomile-0.8.2[ocamlopt] )
	>=dev-ml/findlib-1.2.7
"

DEPEND="${RDEPEND}"

my_emake() {
	emake CAMVER=0.8.2 OCAMLBUILD="ocamlbuild -no-hygiene" ${1+"$@"}
}

src_prepare() {
	epatch "${FILESDIR}/patch-00-batteries-1.3.0-complex-to-of-float" || die "epatch failed"
}

src_compile() {
	my_emake camomile82
	my_emake || die "emake all failed"
	if use doc; then
		my_emake doc || die "emake doc failed"
	fi
}

src_install() {
	DPATH="${D}/$(ocamlfind printconf destdir)"
	mkdir -p "${DPATH}"
	my_emake OCAMLFIND_DESTDIR="${DPATH}" install || die "emake install failed"
	use doc && (my_emake DOCROOT="${D}/usr/share/doc/ocaml-batteries" install-doc || die "make install-doc failed")

	dodoc ocamlinit
}
