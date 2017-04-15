# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="XML parser for Ada95"
HOMEPAGE="https://github.com/AdaCore/xmlada"

EGIT_REPO_URI="https://github.com/AdaCore/${PN}.git"

LICENSE="GPL-3+ gcc-runtime-library-exception-3.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND="virtual/ada:*"
DEPEND="
	${RDEPEND}
	dev-ada/gprbuild:*
	doc? ( dev-python/sphinx:*[latex] )
"

# FIXME: Do a multilib build. Indeed, currently this is installing
# 64-bit shared libraries to "/usr/lib" rather than "/usr/lib64"!

# FIXME: If unnmodified, gprbuild uses RPATH and emerge is forced to
# edit the results. See the QA notices emerge generates, which may
# include other notes, as well. See also
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=569723

HTML_DOCS=""

src_configure() {
	# Make linkage to this library be shared by default.
	econf --enable-shared
}

src_compile() {
	default
	use doc && emake docs
}

src_install() {
	emake install prefix="${D}/usr"
	einstalldocs
	use doc && {
		rm "${D}/usr/share/doc/${PN}/.buildinfo" || :
		dodir "/usr/share/doc/${PF}"
		mv "${D}/usr/share/doc/${PN}/"*.pdf "${D}/usr/share/doc/${PF}/" || die
		mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}/html" || die
	}
}
