# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Oxford Oberon-2 Compiler"
HOMEPAGE="https://spivey.oriel.ox.ac.uk/corner/Oxford_Oberon-2_compiler"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}.tar.xz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# FIXME: I have not checked the dependencies carefully.
RDEPEND="
	dev-lang/ocaml:=
	x11-libs/gtk+:3=
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-Makefile.in.patch" )

RESTRICT="strip"

src_prepare ()
{
	default
	mv configure.in configure.ac || die
	eautoreconf
}

src_install ()
{
	emake \
		prefix="${D}"/usr \
		mandir="${D}"/usr/share/man \
		libdir="${D}"/usr/"$(get_libdir)" \
		install
}
