# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${PN}4-${PV}"

DESCRIPTION="Phil Budne's port of Macro SNOBOL4 in C, for modern machines"
HOMEPAGE="http://www.snobol4.org/"
SRC_URI="ftp://ftp.snobol4.org/snobol/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# FIXME: Add tcl support.
IUSE="doc"

DEPEND="
	sys-devel/gcc:*
	sys-devel/m4:*
	sys-libs/gdbm:=[berkdb]
	doc? (
		 sys-apps/groff:*
	)
"
S=${WORKDIR}/${MY_P}

src_prepare() {
	default

	sed -e '/autoconf/s:autoconf:./autoconf:g' \
		-i configure || die 'autoconf sed failed'
	sed -e 's/$(INSTALL) -s/$(INSTALL)/' \
		-i Makefile2.m4 || die 'strip sed failed'
	echo "ADD_OPT([${CFLAGS}])" >>${S}/local-config
	echo "ADD_CPPFLAGS([-DUSE_STDARG_H])" >>${S}/local-config
	echo "ADD_CPPFLAGS([-DHAVE_STDARG_H])" >>${S}/local-config

	# this cannot work and will cause funny sandbox violations
	sed -i -e 's~/usr/bin/emerge info~~' timing || die "Failed to exorcise the sandbox violations"

	# FIXME: Why is this needed?
	sed -e 's/$(MAKE) -f Makefile2 $@/$(MAKE) -f Makefile2 $@ || :/' \
		-i Makefile || die
}

src_configure() {
	./configure --prefix="${EPREFIX%/}/usr" \
		--snolibdir="${EPREFIX%/}/usr/lib/snobol4" \
		--mandir="${EPREFIX%/}/usr/share/man" \
		--add-cflags="${CFLAGS}"
}

src_compile() {
	emake -j1
	if use doc; then
		ln -s xsnobol4 snobol4 || die
		emake -j1 -C doc html
		emake -j1 -C doc pdf
		rm snobol4 || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README doc/*txt
	if use doc; then
		docinto html
		dodoc doc/*html
	fi
}
