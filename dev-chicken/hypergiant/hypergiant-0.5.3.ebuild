# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Game library"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/glfw3:=
	dev-chicken/glls:=
	dev-chicken/epoxy:=
	dev-chicken/gl-math:=
	dev-chicken/gl-utils:=
	dev-chicken/gl-type:=
	dev-chicken/hyperscene:=
	dev-chicken/noise:=
	dev-chicken/soil:=
	dev-chicken/miscmacros:=
	dev-chicken/srfi18:=
	dev-chicken/srfi42:=
	dev-chicken/srfi99:=
	dev-chicken/bitstring:=
"
DEPEND="${RDEPEND}"
