# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Based in part on 'exheres-mode-1.7.1-r1.exheres-0' which is
#     Copyright 2009 Elias Pipping <pipping@exherbo.org>

EAPI=4

SITEFILE="${FILES}/50${PN}-gentoo.el"

inherit elisp

DESCRIPTION="Major mode for editing files in exheres format"
HOMEPAGE="http://www.exherbo.org"
SRC_URI="http://dev.exherbo.org/~pipping/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${P}/src"
