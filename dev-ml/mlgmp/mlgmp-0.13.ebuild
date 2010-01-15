# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit findlib eutils


DESCRIPTION="Caml GMP - interfaces of GMP (GNU MP) for OCaml"
HOMEPAGE="http://www-verimag.imag.fr/~monniaux/programmes.html.en"
SRC_URI="http://www-verimag.imag.fr/~monniaux/download/${PN}.tar.gz"


LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"


IUSE=""
DEPEND="
    >=dev-lang/ocaml-3.11.0
    >=dev-libs/gmp-4.2.4
    >=dev-ml/ocaml-make-6.28.0
  "

S="${WORKDIR}/${PN}"


create_new_makefile() {
	cd "${S}"
	cat > Makefile <<EOF
CFLAGS   = -Wall -Wno-unused -g -O3
SOURCES  = gmp.mli gmp.ml mlgmp_z.c mlgmp_q.c mlgmp_f.c mlgmp_fr.c mlgmp_random.c mlgmp_misc.c
RESULT   = gmp
all: byte-code-library native-code-library
OCAMLMAKEFILE = /usr/include/OCamlMakefile
include /usr/include/OCamlMakefile
EOF
}

create_meta_file() {
	cd "${S}"
	cat  > META <<EOF
name="gmp"
version="0.13"
description="OCaml interface to GNU MP (extended precision arithmetic)"
archive(byte)="gmp.cma"
archive(native)="gmp.cmxa"
EOF
}

src_unpack() {
	unpack ${PN}.tar.gz || die "unpack failed"
	create_new_makefile
	create_meta_file
}

src_install() {
    # Use findlib to install properly, especially to avoid
    # the shared library mess
    findlib_src_preinst
    ocamlfind install gmp * META
}
