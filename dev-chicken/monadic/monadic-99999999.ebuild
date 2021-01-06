# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial
inherit chicken-egg

DESCRIPTION="Monads for Chicken Scheme"
HOMEPAGE="https://sourceforge.net/p/chemoelectric/${PN}"
SRC_URI=""
EHG_REPO_URI="http://hg.code.sf.net/p/chemoelectric/${PN}"

LICENSE="BSD"
SLOT="0/0"
KEYWORDS=""

IUSE="doc"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/utf8
	dev-chicken/srfi1
	dev-chicken/srfi69
	dev-chicken/matchable
	doc? (
			app-text/docbook-xsl-stylesheets
			app-text/dblatex
			dev-libs/libxml2
			dev-libs/libxslt
		 )
"
DEPEND="${RDEPEND}"

src_prepare() {
	chicken-egg_src_prepare

	# Let’s regenerate the manual’s XML.
	rm -f docs/${PN}-manual.xml

	# Also let’s regenerate the XHTML docs.
	rm -f docs/*.{xhtml,css}
}

src_compile() {
	local emakeflags="CSI=/usr/bin/chicken-csi CSC=/usr/bin/chicken-csc"

	# Speed things up by compiling with the GNUmakefile (which can do
	# parallel builds) instead of chicken-install.
	emake ${emakeflags}

	use doc && emake ${emakeflags} xhtml-docs
	use doc && emake ${emakeflags} pdf-docs
}

src_install() {
	chicken-egg_src_install
	if use doc; then
		dodoc -r monad-5.0

		dodoc docs/${PN}-manual.{sxml,xml,pdf}

		docinto html
		dodoc docs/*.{xhtml,css}
		docinto
	fi
}
