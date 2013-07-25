# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MODULE_AUTHOR="GWOLF"

inherit perl-module

DESCRIPTION="Parse a simple configuration file"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/Test-Pod-Coverage
	dev-perl/Test-Pod
	dev-lang/perl"
RDEPEND="${DEPEND}"
