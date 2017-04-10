# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools git-2

DESCRIPTION="Replacements for parts of POSIX whose behavior is inconsistent among OSes"
HOMEPAGE="https://github.com/sionescu/libfixposix"
EGIT_REPO_URI="https://github.com/sionescu/libfixposix.git"
LICENSE="Boost-1.0"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	default
	eautoreconf
}
