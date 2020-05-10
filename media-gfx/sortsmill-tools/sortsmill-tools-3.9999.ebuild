# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Not compatible with GNU Guile 2.2.2. I suspect that is Guile’s
# fault, not ours. For now, compatible only with 2.0.
GUILE_COMPAT=( guile2_0 )

inherit eutils
inherit autotools
inherit git-r3

DESCRIPTION="Sorts Mill Tools for font development"
HOMEPAGE="https://bitbucket.org/sortsmill/"
EGIT_REPO_URI="https://chemoelectric@bitbucket.org/sortsmill/${PN}.git"
EGIT_BRANCH="Tools3"

LICENSE="GPL-3+"
SLOT="3"
KEYWORDS=""

IUSE="+X gif jpeg tiff"
for target in ${GUILE_COMPAT[@]}; do
	IUSE+=" guile_single_target_${target}"
done

REQUIRED_USE="
	^^ ( ${GUILE_COMPAT[@]/guile/guile_single_target_guile} )
"

COMMON_DEPEND="
	media-libs/libunicodenames
	dev-libs/sortsmill-core

	dev-libs/boehm-gc
	dev-libs/glib
	dev-libs/gmp:0
	dev-libs/libatomic_ops
	dev-libs/libunistring
	media-libs/freetype
	media-libs/libpng:0
	dev-libs/libxml2
	net-misc/wget
	sci-libs/gsl
	sys-libs/zlib

	gif? ( media-libs/giflib )

	tiff? ( media-libs/tiff:0 )

	jpeg? ( virtual/jpeg:0 )

	X? (
	   x11-libs/cairo
	   x11-libs/pango
	   x11-libs/libX11
	   x11-libs/libXi
	   x11-libs/libxkbui
	   x11-libs/libXcursor
	)
"
for target in ${GUILE_COMPAT[@]}; do
	gev_=${target/guile/}
	gev=${gev_/_/.}
	COMMON_DEPEND+="
		guile_single_target_${target}? (
			dev-scheme/guile:${gev}
			dev-scheme/sortsmill-core-guile[guile_targets_${target}]
		)
	"
done
DEPEND="
	${COMMON_DEPEND}
	sys-apps/help2man
"
RDEPEND="
	${COMMON_DEPEND}
"

LINGUA_REPERTOIRE_SRC=":eo :en-US"
LINGUA_REPERTOIRE="${LINGUA_REPERTOIRE_SRC//:/ }"
IUSE+=" ${LINGUA_REPERTOIRE_SRC//:/l10n_}"

ECONF_SOURCE="${S}"

_build_dir() {
	# Outside-of-source build.
	echo "${WORKDIR}/build"
}

_guile_single_target() {
	local t
	for t in ${GUILE_COMPAT[@]}; do
		use guile_single_target_${t} &&	echo ${t}
	done
}

_target_to_gev() {
	echo "${1/guile/}" | tr '_' '.'
}

_gev() {
	echo "$(_target_to_gev $(_guile_single_target))"
}

src_prepare() {
	eapply_user
	eautoreconf
	mkdir "$(_build_dir)" || die
}

src_configure() {
	pushd "$(_build_dir)" >/dev/null

	strip-linguas ${LINGUA_REPERTOIRE}

	local econf_flags=(
		GUILE=guile-$(_gev)

		# FIXME: We could do Python support but the upstream Python
		#        support is slated for removal and replacement, so for
		#        now leave Python out.
		--without-python

		# FIXME: Upstream seems not to work without NLS. DO ALL THE
		#        LINGUAS STUFF FROM GENTOO!
		--enable-nls

		$(use_enable X gui)
		$(use_with gif)
		$(use_with jpeg)
		$(use_with tiff)
	)

	if ! use X; then
		econf_flags+=(
			--without-xi
			--without-xkbui
		)
	fi

	econf ${econf_flags[@]}

	popd >/dev/null
}

src_compile() {
	pushd "$(_build_dir)" >/dev/null
	emake
	popd >/dev/null
}

src_test() {
	pushd "$(_build_dir)" >/dev/null

	#
	# FIXME: The tests are not tested!
	#
	emake check

	popd >/dev/null
}

src_install() {
	pushd "$(_build_dir)" >/dev/null
	emake install DESTDIR="${D}"
	popd >/dev/null
	einstalldocs
}
