# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Based in part on 'exheres-mode-1.7.1-r1.exheres-0' which is
#     Copyright 2009 Elias Pipping <pipping@exherbo.org>

EAPI=4

SITEFILE="${FILES}/50${PN}-gentoo.el"

inherit elisp

DESCRIPTION="Major mode for editing files in exheres format"
HOMEPAGE="http://www.exherbo.org"

# This package no longer is available upstream, and the version 1.9
# requires Emacs 24.
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${P}/src"
