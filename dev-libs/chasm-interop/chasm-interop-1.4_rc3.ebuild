# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib flag-o-matic

DESCRIPTION="Chasm Language Interoperability Tools"
HOMEPAGE="http://chasm-interop.sourceforge.net/"
SRC_URI="mirror://sourceforge/chasm-interop/chasm-interop/chasm_1.4.RC3/chasm_1.4.RC3.tar.gz"

LICENSE="chasm-interop"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples pdtoolkit xalan pic"

DEPEND="
    pdtoolkit? ( >=dev-util/pdtoolkit-3.17 )
    xalan?     ( >=dev-libs/xalan-c-1.11.0_pre1153059 )
    sys-devel/gcc[fortran]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/chasm"

src_configure() {
	local pdt_flag xalan_flag f90_flag

	use pic && append-cflags -fPIC
	use pic && append-cxxflags -fPIC
	use pic && append-fflags -fPIC

	use pdtoolkit && pdt_flag=--with-pdt-root=/usr/$(get_libdir)/pdtoolkit
	use xalan && xalan_flag=--with-xalan-root=/usr
	f90_flag=--with-F90-vendor=GNU

	econf ${pdt_flag} ${xalan_flag} ${f90_flag}
}

src_install() {
	dodir /usr/share/xform
	make install \
		prefix="${D}"usr \
		exec_prefix="${D}"usr \
		includedir="${D}"usr/include \
		libdir="${D}"usr/$(get_libdir) \
		bindir="${D}"usr/bin \
		datadir="${D}"usr/share \
		mandir="${D}"usr/share/man \
		infodir="${D}"usr/share/info || die "make install"

	# Move Fortran module files to where gfortran expects them.
	mv "${D}"usr/$(get_libdir)/*.mod "${D}"usr/include

	dodoc README doc/CCA_Tutorial_Chasm.ppt
	if use examples; then
		cp -r example "${D}"usr/share/doc/${PF}/examples
	fi
}
