# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A compiler for a Scheme-like language targeting the GLSL"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/epoxy:=
	dev-chicken/gl-utils:=
	dev-chicken/miscmacros:=
	dev-chicken/matchable:=
	dev-chicken/fmt:=
	dev-chicken/srfi1:=
	dev-chicken/srfi42:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
