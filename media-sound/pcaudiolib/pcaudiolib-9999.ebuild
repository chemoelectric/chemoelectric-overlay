# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Portable C Audio Library"
HOMEPAGE="https://github.com/espeak-ng/pcaudiolib"
SRC_URI=""
EGIT_REPO_URI="https://github.com/espeak-ng/pcaudiolib.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa oss pulseaudio static-libs"

RDEPEND="
	alsa? ( >=media-libs/alsa-lib-1.0.18 )
	pulseaudio? ( media-sound/pulseaudio )
"
DEPEND="
	${RDEPEND}
	sys-devel/autoconf:*
	sys-devel/automake:*
	sys-devel/libtool:*
	virtual/pkgconfig:*
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with oss) \
		$(use_with alsa) \
		$(use_with pulseaudio)
}

src_install() {
	default
	if ! use static-libs; then
		find "${D}" -name '*.la' -delete || die
	fi
}
