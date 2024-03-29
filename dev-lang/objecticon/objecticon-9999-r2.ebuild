# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs elisp-common autotools

DESCRIPTION="An object-oriented extension of the Icon programming language"
HOMEPAGE="http://chemoelectric.github.io/objecticon"
EGIT_REPO_URI="https://github.com/chemoelectric/objecticon.git"
LICENSE="MIT"

SLOT="0"
KEYWORDS=""
IUSE="doc examples emacs X jpeg png cairo zlib mysql ssl"

COMMON_DEPEND="
	emacs? ( app-editors/emacs:* )
	X? (
		x11-libs/libX11:=
		x11-libs/libXrender:=
		x11-libs/libXft:=
		media-libs/fontconfig:=
		media-libs/freetype:2
	)
	jpeg? ( virtual/jpeg:= )
	png? ( media-libs/libpng:= )
	cairo? ( x11-libs/cairo:= )
	zlib? ( sys-libs/zlib:= )
	mysql? ( virtual/mysql:= )
	ssl? ( dev-libs/openssl:= )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

SITEFILE="50${PN}-mode-gentoo.el"

OI_LIB="${S}/lib"
export OI_PATH="${OI_LIB}/main:${OI_LIB}/gui:${OI_LIB}/xml:${OI_LIB}/parser:${OI_LIB}/ipl"
export OI_INCL="${OI_LIB}/incl"

src_prepare() {
	default
	eautoconf
}

my_use_with() {
	local without=
	use $1 || without="--without-$2"
	printf "%s" "${without}"
}

src_configure() {
	# FIXME: Do these options all actually work as advertised? Test
	# them.

	# econf does not work correctly here.
	env CC="$(tc-getCC)" ./configure \
		$(my_use_with X X11) \
		$(my_use_with jpeg jpeg) \
		$(my_use_with png png) \
		$(my_use_with cairo cairo) \
		$(my_use_with zlib zlib) \
		$(my_use_with mysql mysql) \
		$(my_use_with ssl openssl) || die
}

src_compile() {
	default
	use doc && emake libref
	use emacs && elisp-compile "misc/${PN}-mode.el"
}

src_test() {
	emake test CC="$(tc-getCC)"
}

src_install() {
	local bindir="/usr/bin"
	local libdir="/usr/lib/${PN}"

	# Installing binaries this way keeps symbolic links as such.
	dodir "${bindir}"
	cp -P bin/* "${D}${bindir}" || die

	dodir "${libdir}"
	cp -R lib/* "${D}${libdir}" || die
	#
	# FIXME: Consider removing the Makefiles under "${D}${libdir}". Are
	# any of these useful to have there?
	#

	einstalldocs
	use doc && dodoc -r libref

	use examples && dodoc -r examples

	# Patch all Object Icon executables to account for the new
	# location of oix.
	pushd "${D}"
	for f in $(find -P . -type f -executable); do
		[[ ! -h "${f}" ]] &&
			env OI_HOME="${S}" PATH="${S}/bin" \
				"oipatch" -i "${f}" "/usr/bin/oix" || :
	done
	popd

	(
		echo "OI_HOME=/usr"
		echo "OI_PATH='${libdir}/main:${libdir}/gui:${libdir}/xml:${libdir}/parser:${libdir}/ipl'"
		echo "OI_INCL='${libdir}/incl'"
		echo "OI_NATIVE='${libdir}/native'"
	) > "${T}/50objecticon"
	doenvd "${T}/50objecticon"

	use emacs && {
		elisp-install "${PN}" misc/"${PN}"-mode.{el,elc}
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
		dodoc misc/objecticon-setup.el
	}
}

pkg_postinst() {
	use emacs && elisp-site-regen

	einfo
	einfo "To use Object Icon in an already running shell, do:"
	einfo
	einfo "source /etc/profile"
	einfo
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
