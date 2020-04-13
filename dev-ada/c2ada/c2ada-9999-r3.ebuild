# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit git-r3 toolchain-funcs python-any-r1

#WHOSE_GITHUB=mikequentel
WHOSE_GITHUB=chemoelectric

DESCRIPTION="Translate C headers and functions into Ada"
HOMEPAGE="https://github.com/${WHOSE_GITHUB}/c2ada"
EGIT_REPO_URI="https://github.com/${WHOSE_GITHUB}/c2ada.git"
LICENSE="MIT"

SLOT="0"
KEYWORDS=""
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
		Makefile || die
	sed -i -e 's|/lib/|/'"$(get_libdir)"'/|g' Makefile || die
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
	sed -i -e 's|\(Py_Initialize();\)|\1 '"${syspath_code}"'|g' *.c
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
