# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="CUPS driver (US edition) for Canon printers whose PCL is UFR II"

HOMEPAGE="http://usa.canon.com/"
SRC_URI="linux-UFRII-drv-v510-usen-09.tar.gz"

LICENSE="LICENSE-EN-ufr2-5.10"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="fetch"

# FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME
#
# FIXME: Check if these dependencies are still correct.
#
# FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME
COMMON_DEPEND="
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/libxml2
	media-libs/fontconfig
	media-libs/libpng-compat:1.2
	gnome-base/libglade
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	app-text/ghostscript-gpl
	net-print/cups
"
DEPEND="${COMMON_DEPEND} app-arch/dpkg app-arch/gzip app-arch/tar"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}"

top_dir() {
	echo "${WORKDIR}/linux-UFRII-drv-v510-usen"
}

deb_ufr2_file() {
	if use amd64; then
		echo "$(top_dir)/64-bit_Driver/Debian/cnrdrvcups-ufr2-us_5.10-1_amd64.deb"
	elif use x86; then
		echo "$(top_dir)/32-bit_Driver/Debian/cnrdrvcups-ufr2-us_5.10-1_i386.deb"
	fi
}

pkg_nofetch() {
	einfo "Please download \`UFR II/UFRII LT Printer Driver for Linux V5.10'" from
	einfo "https://www.usa.canon.com/internet/portal/us/home/support/details/printers/black-and-white-laser/mf4890dw?tab=drivers_downloads"
	einfo "and put the file in ${DISTDIR}"
}

src_unpack() {
	default
	dpkg -x "$(deb_ufr2_file)" . || die
}

src_install() {
	keepdir /etc/cngplp/account/

	dobin usr/bin/*

	dodir /usr
	cp -R usr/share "${D}/usr" || die

	dodoc "$(top_dir)/Documents/"*.html

	dolib.so usr/lib/*.{so,so.*}

	local cupsexec="/usr/libexec/cups/"
	for subdir in backend filter; do
		dodir "${cupsexec}${subdir}"
		exeinto "${cupsexec}${subdir}"
		doexe "usr/lib/cups/${subdir}/"*
	done
}
