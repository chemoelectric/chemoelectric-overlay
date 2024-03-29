# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Client interface to the Memcached protocol"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/base64:=
	dev-chicken/srfi13:=
	dev-chicken/srfi14:=
"
DEPEND="${RDEPEND}"
