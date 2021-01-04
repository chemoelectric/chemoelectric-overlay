# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="The SLIB character plotting library"

LICENSE="Artistic"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/slib-arraymap:=
	dev-chicken/srfi63:=
"
DEPEND="${RDEPEND}"
