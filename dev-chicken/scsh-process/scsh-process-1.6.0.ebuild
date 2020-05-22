# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A reimplementation for CHICKEN of SCSH's process notation"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/srfi18-1.4:=
	>=dev-chicken/llrb-tree-0.3.8:=
"
DEPEND="${RDEPEND}"
