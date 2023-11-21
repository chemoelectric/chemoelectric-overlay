# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Access Chicken functions from any shell and access zsh functions from Chicken"

LICENSE="LGPL-3+"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	app-shells/zsh:=
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/brev:=
"
DEPEND="${RDEPEND}"
