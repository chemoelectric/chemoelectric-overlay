# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Computes MD5 (RFC1321) checksums"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0_rc3:=
	>=dev-chicken/message-digest-primitive-4.1.0:=
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}.patch )