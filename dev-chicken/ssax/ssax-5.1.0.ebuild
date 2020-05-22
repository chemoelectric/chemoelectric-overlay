# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Oleg Kiselyov's XML parser"

LICENSE="public-domain"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/input-parse-1.2:=
	>=dev-chicken/srfi1-1.4:=
	>=dev-chicken/srfi13-1.4:=
"
DEPEND="${RDEPEND}"
