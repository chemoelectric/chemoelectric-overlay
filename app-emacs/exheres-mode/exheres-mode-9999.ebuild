# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Based in part on 'exheres-mode-1.7.1-r1.exheres-0' which is
#     Copyright 2009 Elias Pipping <pipping@exherbo.org>

EAPI=5

SITEFILE="${FILES}/50${PN}-gentoo.el"

# Do not use the Autotooling that is in the package; instead use
# elisp.eclass.
inherit elisp git-2

DESCRIPTION="Major mode for editing files in exheres format"
HOMEPAGE="http://www.exherbo.org"
EGIT_REPO_URI="git://git.exherbo.org/${PN}"
EGIT_SOURCEDIR="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/src"
