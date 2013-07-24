# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://git.fedorahosted.org/git/${PN}.git"

inherit eutils user git-2

DESCRIPTION="create chroots and build packages in them for Fedora and RedHat"
HOMEPAGE="http://fedoraproject.org/wiki/Projects/Mock"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="sys-apps/yum
	app-arch/rpm[python,lua]
	dev-python/decoratortools"

src_prepare() {
	./autogen.sh
}

pkg_postinst() {
	enewgroup mock
}
