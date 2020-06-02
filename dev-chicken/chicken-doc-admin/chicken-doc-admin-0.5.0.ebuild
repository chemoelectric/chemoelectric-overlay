# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Administer Chicken documentation locally"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/matchable:=
	>=dev-chicken/chicken-doc-0.6.0:=
	dev-chicken/html-parser:=
	dev-chicken/sxml-transforms:=
	>=dev-chicken/svnwiki-sxml-0.2.12:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi69:=
	dev-chicken/regex:=
"
DEPEND="${RDEPEND}"

pkg_postinst() {
	chicken-egg_pkg_postinst

	elog
	elog "To set up a \`personal' chicken-doc repository,"
	elog "put something like"
	elog
	elog "  export CHICKEN_DOC_REPOSITORY=\"/path/to/some/writable/directory\""
	elog
	elog "in your shell initialization scripts, reinitialize"
	elog "the shell (e.g., . ~/.bashrc), and then run"
	elog
	elog "  chicken-doc-admin -i"
	elog "  svn co --username anonymous --password \"\" \\"
	elog "     https://code.call-cc.org/svn/chicken-eggs/wiki"
	elog "  chicken-doc-admin -m wiki/man/5"
	elog "  chicken-doc-admin -e wiki/eggref/5"
	elog
}
