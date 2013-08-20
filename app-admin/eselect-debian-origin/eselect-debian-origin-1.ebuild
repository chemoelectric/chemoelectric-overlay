# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

# alternatives-2.eclass, currently from the science overlay.
inherit alternatives-2

DESCRIPTION="Alternatives for Debian-derived distribution origin"
HOMEPAGE="http://FIXME"

LICENSE="FIXME"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_unpack() {
	# Copy these rather than install directly from ${FILESDIR}, to
	# avoid having doins copy draft-Posix ACLs.
	cp "${FILESDIR}/${PV}/origins"/* . || die
}

src_install() {
	insinto /etc/dpkg/origins
	doins *

	for origin in *; do
		orig=`basename "${origin}"`
		alternatives_for debian-origin "${orig}" 0 \
			/etc/dpkg/origins/default "${orig}"
	done
}
