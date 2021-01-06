# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="libgit2 bindings"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/libgit2-1.1.0-r2:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/foreigners:=
	dev-chicken/module-declarations:=
	dev-chicken/srfi1:=
"
