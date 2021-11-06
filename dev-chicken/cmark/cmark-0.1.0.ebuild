# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A chicken wrapper for cmark with markdown to sxml capabilities"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=app-text/cmark-0.30.2:=
	>=dev-scheme/chicken-5.3.0_rc4:=
"
DEPEND="${RDEPEND}"
