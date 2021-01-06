# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Chicken bindings to the ICU unicode library"

LICENSE="unicode"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/icu:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/utf8:=
	dev-chicken/srfi13:=
	dev-chicken/srfi1:=
	dev-chicken/foreigners:=
"
DEPEND="${RDEPEND}"

src_prepare() {
	chicken-egg_src_prepare

	# Chalk isn’t working for us, so de-chalkify the sources.

	# Replace chalk comments with ordinary expression comments.
	sed -i -e 's|@(|#;(|g' icu.scm || die

	# Do not load chalk into the compiler.
	sed -i -e 's|[ 	]-X[ 	]chalk[ 	]| |' icu.egg || die

	# Remove dependence on chalk.
	sed -i -e 's|\((dependencies[ 	].*\)chalk|\1|' icu.egg || die
}
