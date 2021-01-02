# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="eSpeak NG Text-to-Speech engine"
HOMEPAGE="https://github.com/espeak-ng/espeak-ng"
SRC_URI=""
EGIT_REPO_URI="https://github.com/espeak-ng/espeak-ng.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+async +extdict-ru +extdict-zh +extdict-zhy +klatt +mbrola +speechplayer"
IUSE="${IUSE} +pcaudiolib"
IUSE="${IUSE} +sonic"
IUSE="${IUSE} static-libs"
IUSE="${IUSE} doc"

RDEPEND="
	pcaudiolib? ( media-sound/pcaudiolib )
	sonic? ( media-sound/sonic )
"

# Ronn is needed for the manpages. Kramdown is used to make html.
# FIXME: Maybe make Ronn optional, and install without manpages if
# Ronn is not used.
DEPEND="
	${RDEPEND}
	>=sys-devel/autoconf-2.69:*
	sys-devel/automake:*
	sys-devel/libtool:*
	virtual/pkgconfig:*
	app-text/ronn:*
	doc? ( dev-ruby/kramdown:* )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with async) \
		$(use_with extdict-ru) \
		$(use_with extdict-zh) \
		$(use_with extdict-zhy) \
		$(use_with klatt) \
		$(use_with mbrola) \
		$(use_with pcaudiolib) \
		$(use_with sonic) \
		$(use_with speechplayer) \
		--with-libfuzzer=no
}

src_compile() {
	emake -j1
	use doc && emake -j1 docs
}

src_install() {
	default

	# Remove espeak-compatibility, so we can co-exist with
	# app-accessibility/espeak.
	rm -f "${D}/usr/bin/espeak"
	rm -R -f "${D}/usr/include/espeak"

	# Remove speak-compatibility, so we could (in theory) co-exist
	# with speak.
	rm -f "${D}/usr/bin/speak"

	if ! use static-libs; then
		find "${D}" -name '*.la' -delete || die
	fi

	if use doc; then
		cp -R docs "${T}/html" || die
		rm -f `find "${T}/html" -name '*.md'`
		dodoc -r "${T}/html"
		dodoc README.html CHANGELOG.html
	fi
}
