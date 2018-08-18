# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 multilib

CHEZSCHEME_="ChezScheme"

DESCRIPTION="SRFIs for Chez Scheme"
HOMEPAGE="https://github.com/arcfide/chez-srfi"
EGIT_REPO_URI="https://github.com/arcfide/chez-srfi.git"

# FIXME: The following license notice is not adequate.
LICENSE="chez-srfi"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-scheme/${CHEZSCHEME_}:0
"
RDEPEND="
	${DEPEND}
"

MY_WORK_SRCDIR="${WORKDIR}/src"
MY_WORK_OBJDIR="${WORKDIR}/obj"

my_srcdir() {
	echo "/usr/share/${CHEZSCHEME_}"
}

my_objdir() {
	echo "/usr/$(get_libdir)/${CHEZSCHEME_}"
}

src_prepare() {
	default
	scheme --program link-dirs.chezscheme.sps || die
	find . -name '*.s[lp]s' -type f -exec sed -i -e 's/%3a/:/g' '{}' ';' || die
}

src_compile() {
	ln -s . srfi || die
	echo '(compile-imported-libraries #t)' |
		cat - compile-all.ikarus.sps |
		scheme -q --libdirs ".::${MY_WORK_OBJDIR}"
	rm srfi || die
}

src_install() {
	dodoc README*

	# Prepare the source libraries.
	mkdir -p "${MY_WORK_SRCDIR}/srfi" || die
	cp -R --dereference * "${MY_WORK_SRCDIR}/srfi" || die
	pushd 2>/dev/null "${MY_WORK_SRCDIR}/srfi" || die
	rm -f -R \
	   LICENSE* \
	   README* \
	   compile-all.ikarus.sps \
	   link-dirs.chezscheme.sps \
	   tests
	rm -R ./%3a* || die
	popd 2>/dev/null || die

	# Install the source libraries.
	dodir "$(my_srcdir)"
	insinto "$(my_srcdir)"
	pushd 2>/dev/null "${MY_WORK_SRCDIR}" || die
	doins -r srfi
	popd 2>/dev/null || die

	# Install the compiled libraries.
	dodir "$(my_objdir)"
	insinto "$(my_objdir)"
	pushd 2>/dev/null "${MY_WORK_OBJDIR}" || die
	doins -r srfi
	popd 2>/dev/null || die
}
