# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="LLRB tree general and customized to key types"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/srfi128-0.11:=
	>=dev-chicken/miscmacros-1.0:=
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-chicken/llrb-syntax-0.2:="
