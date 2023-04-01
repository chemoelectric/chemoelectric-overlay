# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Otus Lisp (Ol), a purely functional dialect of Scheme"
HOMEPAGE="https://github.com/yuriy-chumak/ol"
EGIT_REPO_URI="https://github.com/yuriy-chumak/ol.git"
LICENSE="MIT LGPL-3+"

SLOT="0"
KEYWORDS=""

# app-editors/vim-core is needed for xxd.
BDEPEND="app-editors/vim-core:*"

# Owl Lisp and Otus Lisp both are called "ol".
RDEPEND="!!dev-scheme/owl-lisp"
DEPEND="${RDEPEND}"

src_prepare ()
{
	default

	# FIXME: Maybe a patch would be a better approach here:
	sed -i -e 's|gzip <ol.1 >$(DESTDIR)$(PREFIX)/share/man/man1/ol.1.gz|install ol.1 $(DESTDIR)$(PREFIX)/share/man/man1/ol.1|' extras/setup.mk || die
}

src_configure ()
{
	:
}

src_compile ()
{
	emake CC="$(tc-getCC)" LD="$(tc-getLD)"
}

src_install ()
{
	default

	# FIXME: HIDEOUSLY UGLY HACK!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	if [[ "$(get_libdir)" != "lib" ]]; then
		dodir "/usr/$(get_libdir)"
		mv "${ED}/usr/lib/libol.so" "${ED}/usr/$(get_libdir)" || die
	fi

	dodoc README* THANKS
	dodoc quine.lisp
	dodoc -r samples
}
