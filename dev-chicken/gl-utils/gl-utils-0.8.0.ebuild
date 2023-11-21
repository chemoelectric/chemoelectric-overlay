# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="High(er) level tools for OpenGL"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/z3:=
	dev-chicken/matchable:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi99:=
	dev-chicken/srfi42:=
	dev-chicken/epoxy:=
	dev-chicken/gl-math:=
"
DEPEND="${RDEPEND}"
