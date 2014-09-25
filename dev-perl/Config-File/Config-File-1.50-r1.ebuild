# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR="GWOLF"

inherit perl-module

DESCRIPTION="Parse a simple configuration file"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/Test-Pod-Coverage
	dev-perl/Test-Pod
	dev-lang/perl"
RDEPEND="${DEPEND}"
