# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A command-line-based password manager"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/stty:=
	dev-chicken/tweetnacl:=
	dev-chicken/args:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi69:=
	dev-chicken/matchable:=
"
DEPEND="${RDEPEND}"
