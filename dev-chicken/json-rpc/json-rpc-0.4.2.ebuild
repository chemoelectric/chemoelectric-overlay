# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A JSON RPC library for R7RS scheme"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/r7rs:=
	dev-chicken/srfi1:=
	dev-chicken/srfi18:=
	dev-chicken/srfi69:=
	dev-chicken/srfi180:=
"
DEPEND="${RDEPEND}"
