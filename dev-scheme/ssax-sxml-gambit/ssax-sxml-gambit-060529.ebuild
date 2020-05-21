# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs multilib

DESCRIPTION="Functional XML and SXML parsing framework"
HOMEPAGE="https://sourceforge.net/projects/ssax/"
SRC_URI="mirror://sourceforge/ssax/${P}.tgz"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEPEND="
	>=dev-scheme/gambit-4.9.3:=
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
"

S="${WORKDIR}/ssax-sxml"

PATCHES=(
	# The names of fixnum operations have changed.
	"${FILESDIR}/fixnum.patch"

	# Mysterious quasiquote problems in sxml-tools/modif.scm
	# which compiling with dev-scheme/gambit-4.9.3::lisp
	"${FILESDIR}/modif.scm.patch"
)

SCHEME_FILES=( libs/gambit/common.scm libs/gambit/myenv.scm
	libs/srfi-13-local.scm libs/util.scm libs/gambit/parse-error.scm
	libs/input-parse.scm libs/look-for-str.scm ssax/char-encoding.scm
	ssax/SSAX-code.scm ssax/SXML-tree-trans.scm
	sxml-tools/sxpathlib.scm multi-parser/id/srfi-12.scm
	multi-parser/id/mime.scm multi-parser/id/http.scm
	multi-parser/id/access-remote.scm multi-parser/id/id.scm
	sxml-tools/xlink-parser.scm multi-parser/ssax-prim.scm
	multi-parser/multi-parser.scm html-prag/htmlprag.scm
	sxml-tools/sxml-tools.scm sxml-tools/sxpath-ext.scm
	sxml-tools/xpath-parser.scm sxml-tools/txpath.scm
	sxml-tools/sxpath.scm sxml-tools/xpath-ast.scm
	sxml-tools/xpath-context.scm sxml-tools/xlink.scm
	sxml-tools/ddo-axes.scm sxml-tools/ddo-txpath.scm
	sxml-tools/lazy-xpath.scm ssax/lazy-ssax.scm sxml-tools/modif.scm
	sxml-tools/serializer.scm sxml-tools/guides.scm stx/libmisc.scm
	stx/stx-engine.scm )

my_clean() {
	rm -f ${SCHEME_FILES[@]/.scm/.c}
	rm -f ${SCHEME_FILES[@]/.scm/.o}
}

my_gsc() {
	printf "%s" "gsc -verbose"
}

my_libname() {
	printf "%s" "ssax-sxml"
}

my_libdir() {
	printf "%s" "/usr/$(get_libdir)"
}

my_pkglibdirname() {
	printf "%s" "${PN}"
}

my_pkglibdir() {
	# FIXME:
	# FIXME: One would seem to have to specify the path to
	# FIXME: the directory explicitly, when using the loadable
	# FIXME: library, or when compiling with the shared library.
	# FIXME:
	printf "%s" "$(my_libdir)/$(my_pkglibdirname)"
}

src_configure() {
	:
}

src_compile() {

	einfo "Building the loadable library ..."
	my_clean
	$(my_gsc) -link -flat -o "$(my_libname).o1.c" ${SCHEME_FILES[@]} || die
	$(my_gsc) -cc-options "-D___DYNAMIC" -obj ${SCHEME_FILES[@]/.scm/.c} "$(my_libname).o1.c" || die
	local link_loadable="$(tc-getCC) ${CFLAGS} -shared ${SCHEME_FILES[@]/.scm/.o} $(my_libname).o1.o -o $(my_libname).o1"
	printf "%s\n" "${link_loadable}"
	${link_loadable} || die

	#
	# FIXME: Currently the shared library does not work
	# FIXME: when I am using dev-scheme/gambit-4.9.3::lisp
	#
	#einfo "Building the shared library ..."
	#my_clean
	#$(my_gsc) -link -o "$(my_libname).c" ${SCHEME_FILES[@]} || die
	#$(my_gsc) -cc-options "-D___SHARED" -obj ${SCHEME_FILES[@]/.scm/.c} "$(my_libname).c" || die
	#local link_shared="$(tc-getCC) ${CFLAGS} -shared -Wl,--enable-new-dtags,-rpath,$(my_pkglibdir) ${SCHEME_FILES[@]/.scm/.o} $(my_libname).o  -o $(my_libname).so"
	#printf "%s\n" "${link_shared}"
	#${link_shared} || die
}

src_test() {
	# FIXME: Currently only the loadable module is tested.
	einfo "Running tests ..."
	gsi -e '(load "ssax-sxml")(load "test-sxml.scm")' \
		| fgrep -q 'All tests passed successfully!' \
		|| die "The src_test phase has failed."
	einfo ">> Tests passed <<"
}

src_install() {
	dodoc doc.txt

	dodoc -r apidoc

	dodoc example.*
	dodoc -r XML

	dodir "$(my_pkglibdir)"
	insinto "$(my_pkglibdir)"
	doins "$(my_libname)".o1	# The (flat) loadable library.

	#
	# FIXME: Currently the shared library does not work.
	#
	#doins "$(my_libname)".c	# The incremental link file.
	#doins "$(my_libname)".so	# The shared library.

	cat > "${T}/${PN}.pc" << EOF || die
prefix=/usr
exec_prefix=\${prefix}
libdir=$(my_libdir)
pkglibdir=$(my_pkglibdir)

Name: ${PN}
Description: ${DESCRIPTION}
Version: 060529
EOF
	insinto "$(my_libdir)/pkgconfig"
	doins "${T}/${PN}.pc"
}

pkg_postinst() {
	elog
	elog "To load the loadable library from Gambit Scheme:"
	elog
	elog "    (load \"$(my_pkglibdir)/ssax-sxml\")"
	elog
	elog "Running"
	elog
	elog "    pkg-config --variable=pkglibdir ${PN}"
	elog
	elog "will print"
	elog
	elog "    $(my_pkglibdir)"
	elog
	elog "which is the directory part of the load path"
	elog "for the ssax-sxml library. Thus, for example,"
	elog
	elog "    gsi -e \"(load \\\"\$(pkg-config --variable=pkglibdir ssax-sxml-gambit)/ssax-sxml\\\")(pretty-print sxml:document)\""
	elog
	elog "should print something like"
	elog
	elog "    #<procedure #2 sxml:document>"
	elog
}
