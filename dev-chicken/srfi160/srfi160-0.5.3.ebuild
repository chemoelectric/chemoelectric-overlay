# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="SRFI 160: Homogeneous numeric vector libraries"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi128:=
"
DEPEND="${RDEPEND}"

#
# In CHICKEN 5.2.0, set-sharp-read-syntax! cannot take a symbol as its
# first argument. This bug is easily overcome, by using set-read-syntax!
# instead.
#
# There seems to be a general problem with eggs, that they may be
# written by people using development versions of CHICKEN, who then do
# not test on the released version.
#
PATCHES=( "${FILESDIR}/${P}.patch" )
