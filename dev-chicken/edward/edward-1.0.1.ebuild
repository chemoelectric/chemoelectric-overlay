# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="An extensible implementation of the ed text editor as defined in POSIX.1-2008"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/r7rs:=
	dev-chicken/srfi1:=
	dev-chicken/srfi14:=
	dev-chicken/srfi37:=
	dev-chicken/matchable:=
	dev-chicken/posix-regex:=
"
DEPEND="${RDEPEND}"
