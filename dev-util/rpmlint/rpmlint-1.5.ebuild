# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Checks common problems in RPM packages"
HOMEPAGE="http://rpmlint.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	>=dev-lang/python-2.4
	>=app-arch/rpm-4.4.2.2[python]
	sys-apps/sed
"
RDEPEND="
	>=dev-lang/python-2.4
	>=app-arch/rpm-4.4.2.2[python]
	sys-apps/file
	sys-devel/binutils
	app-arch/cpio
	dev-util/desktop-file-utils
	app-arch/gzip
	app-arch/bzip2
	app-arch/xz-utils
	sys-apps/groff
	app-text/enchant
	dev-python/pyenchant
"
