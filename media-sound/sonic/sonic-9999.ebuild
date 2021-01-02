# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils git-r3

DESCRIPTION="Simple library to speed up or slow down speech"
HOMEPAGE="https://github.com/espeak-ng/sonic"
SRC_URI=""
EGIT_REPO_URI="https://github.com/espeak-ng/sonic.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

RDEPEND="sci-libs/fftw:3.0="
DEPEND="${RDEPEND}"

src_prepare() {
	cd "${WORKDIR}"/${P} || die
	eapply "${FILESDIR}"/${P}-fix-lib.patch

	eapply_user
}

src_install() {
	emake DESTDIR="${D}" SONIC_LIBDIR="$(get_libdir)" install

	if ! use static-libs; then
		find "${D}" -name '*.a' -delete || die
		find "${D}" -name '*.la' -delete || die
	fi
}
