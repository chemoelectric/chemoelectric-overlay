# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# FIXME: Ideally one could have multiple versions of gnatprove
#        installed, and selectable by eselect. This ebuild does not
#        achieve that goal.

DESCRIPTION="Formal prover for Ada/SPARK"
HOMEPAGE="https://www.adacore.com/about-spark"

GENERAL_NAME=gnatprove-12.1.0-1
AMD64_NAME=gnatprove-x86_64-linux-12.1.0-1

SRC_URI="
	amd64? ( https://github.com/alire-project/GNAT-FSF-builds/releases/download/${GENERAL_NAME}/${AMD64_NAME}.tar.gz )
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

directory() {
	use amd64 && echo "${AMD64_NAME}"
}

src_install() {
	dodir opt
	cp -R "$(directory)" "${ED}"/opt || die
	find "${ED}" -name '*.la' -exec rm '{}' ';' || die

	printf "#!/bin/bash\nexec /opt/%s/bin/gnatprove \"\${@}\"" \
		   "$(directory)" > gnatprove || die
	dobin gnatprove

	dodir /usr/share/doc/"${PF}"
	dosym "../../../../opt/$(directory)/share/examples" \
		  /usr/share/doc/"${PF}"/examples
}
