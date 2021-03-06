# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Chicken Scheme bindings for the lightweight ZMQ-alternative, nanomsg"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/nanomsg-1.0.0:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/foreigners:=
	dev-chicken/srfi18:=
"
DEPEND="${RDEPEND}"

# Shorten the version to 1.0.0, because 1.0.0.x is not a legal
# Chicken Egg version.
PATCHES=( "${FILESDIR}"/nanomsg.egg.patch )

src_prepare() {
	default
}
