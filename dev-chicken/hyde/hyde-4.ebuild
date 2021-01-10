# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A static website compiler"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/sxml-transforms:=
	dev-chicken/doctype:=
	dev-chicken/matchable:=
	dev-chicken/scss:=
	dev-chicken/spiffy:=
	dev-chicken/colorize:=
	dev-chicken/intarweb:=
	dev-chicken/uri-common:=
	dev-chicken/svnwiki-sxml:=
	dev-chicken/defstruct:=
	dev-chicken/sxpath:=
	dev-chicken/html-parser:=
	dev-chicken/atom:=
	dev-chicken/rfc3339:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"

pkg_postinst() {
	elog "To use dev-chicken/lowdown for Markdown pages,"
	elog "put the following in your website’s hyde.scm:"
	elog ""
	elog " (import (lowdown))"
	elog " (translators (cons (list \"md\" markdown->html) (translators)))"
	elog ""
	elog "By default, your PATH is searched for a \`markdown' command."
}
