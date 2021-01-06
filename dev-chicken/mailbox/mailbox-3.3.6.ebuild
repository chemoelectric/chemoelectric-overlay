# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Thread-safe queues with timeout"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	>=dev-chicken/srfi1-0.2:=
	>=dev-chicken/srfi18-0.1:=
	>=dev-chicken/record-variants-1.1:=
"
DEPEND="${RDEPEND}"
