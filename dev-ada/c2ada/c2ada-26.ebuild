# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit toolchain-funcs python-any-r1

DESCRIPTION="Translate C headers and functions into Ada"
HOMEPAGE="http://c2ada.sourceforge.net/c2ada.html"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}.tar.xz"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	app-shells/tcsh
	>=dev-util/gperf-3.1
	virtual/yacc
"
RDEPEND=""

src_prepare() {
	default

	sed -i -e 's/^CFLAGS[ 	]*=[ 	]*\$(GNU_C_OPTS)[ 	]*/CFLAGS += /'	\
		Makefile
	rm -f Makefile.config

	local syspath_code='{ const char *syspath = Py_GetPath(); \
const char *my_dir = "/usr/share/'"${PN}"'"; \
char *new_syspath = malloc (strlen (my_dir) + strlen (syspath) + 2); \
if (new_syspath == NULL) abort (); \
strcpy (new_syspath, my_dir); \
strcat (new_syspath, ":"); \
strcat (new_syspath, syspath); \
PySys_SetPath (new_syspath); \
}'

	sed -i-e 's|\(Py_Initialize();\)|\1 '"${syspath_code}"'|g' *.c
}

src_configure() {
	:
}

src_compile() {
	# FIXME: The way Python paths are resolved in the Makefile is
	# archaic. Update it. For now, this works.
	emake PYTHON_VER="${EPYTHON}" \
		LINKER="$(tc-getCC)" \
		RANLIB="$(tc-getRANLIB)" \
		GPERF="gperf -I"
}

src_install() {
	dobin "${PN}"

	dodir /usr/share/"${PN}"
	insinto /usr/share/"${PN}"
	doins *.py

	einstalldocs
	dodoc "${PN}".html
}
