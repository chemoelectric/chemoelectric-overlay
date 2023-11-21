# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Filesystems in Userspace"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	=sys-fs/fuse-2*:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi18:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-chicken/foreigners:=
	dev-chicken/matchable:=
	dev-chicken/module-declarations:=
"
