# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A template engine inspired by Jinja2 and Jingoo"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/datatype:=
	dev-chicken/silex:=
	dev-chicken/lalr:=
	dev-chicken/utf8:=
	dev-chicken/uri-generic:=
	dev-chicken/srfi1:=
"
DEPEND="${RDEPEND}"
