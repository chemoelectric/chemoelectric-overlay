# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Virtual for gnatdoc"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# FIXME: Change the following if a gnatdoc becomes available for other
# than amd64.
REQUIRED_USE="|| ( amd64 )"

# Currently there is only one way to get gnatdoc, and that is to
# install the entire GNAT GPL binary package.
RDEPEND="
	|| (
		amd64? ( dev-lang/gnat-gpl-bin:${PV} )
	)
"
