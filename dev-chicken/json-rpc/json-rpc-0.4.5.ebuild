# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A JSON RPC library for R7RS scheme"

# Use the ‘a’ patchlevel.
SRC_URI="
	https://code.call-cc.org/egg-tarballs/${CHICKEN_MAJOR_VERSION}/${CHICKEN_EGG_PN}/${CHICKEN_EGG_P}a.tar.gz
		-> chicken-${P}.tar.gz
"

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
	dev-chicken/utf8:=
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${CHICKEN_EGG_P}"a
