# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://yum.baseurl.org/${PN}.git"

inherit git-2

DESCRIPTION="Utilities and plugins extending and supplementing yum in different ways"
HOMEPAGE="http://yum.baseurl.org/wiki/YumUtils"
LICENSE="GPL-2+"

SLOT="0"
KEYWORDS=""
IUSE=""

# FIXME.
RDEPEND=""
DEPEND="${RDEPEND}"
