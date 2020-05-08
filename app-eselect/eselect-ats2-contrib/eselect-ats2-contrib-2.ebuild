# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Manages ATS2/Postiats implementations"
HOMEPAGE="https://bitbucket.org/sortsmill/sortsmill-gentoo-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${FILESDIR}/${PVR}"

src_install() {
	insinto /usr/share/eselect/modules
	doins ats2-contrib.eselect
}
