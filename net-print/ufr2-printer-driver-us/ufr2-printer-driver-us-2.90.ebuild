# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="CUPS driver (US edition) for Canon printers whose printer control language is UFR II"

HOMEPAGE="http://usa.canon.com/cusa/support/consumer/printers_multifunction/imageclass_series/imageclass_mf4890dw#DriversAndSoftware"
SRC_URI="Linux_UFRII_PrinterDriver_V290_us_EN.tar.gz"

LICENSE="LICENSE-common-2.90 LICENSE-ufr2drv-2.90"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="fetch"

COMMON_DEPEND="
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/libxml2
	media-libs/fontconfig
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

pkg_setup() {
	export TOP_DIR="Linux_UFRII_PrinterDriver_V290_us_EN"
	export DEB_COMMON_FILE
	export DEB_UFR2_FILE
	use x86 && {
		DEB_COMMON_FILE="${TOP_DIR}/64-bit_Driver/Debian/cndrvcups-common_2.90-1_i386.deb"
		DEB_UFR2_FILE="${TOP_DIR}/64-bit_Driver/Debian/cndrvcups-ufr2-us_2.90-1_amd64.deb"
	}
	use amd64 && {
		DEB_COMMON_FILE="${TOP_DIR}/64-bit_Driver/Debian/cndrvcups-common_2.90-1_amd64.deb"
		DEB_UFR2_FILE="${TOP_DIR}/32-bit_Driver/Debian/cndrvcups-ufr2-us_2.90-1_i386.deb"
	}
}

pkg_nofetch() {
	einfo "Please download \`UFR II Printer Driver for Linux Version 2.90'"
	einfo "from the \`Drivers & Software->Drivers' submenu at"
	einfo "http://usa.canon.com/cusa/support/consumer/printers_multifunction/imageclass_series/imageclass_mf4890dw"
	einfo "and put the file in ${DISTDIR}"
}

src_unpack() {
	default
	dpkg -x "${DEB_COMMON_FILE}" . || die "dpkg failed for ${DEB_COMMON_FILE}"
	dpkg -x "${DEB_UFR2_FILE}" . || die "dpkg failed for ${DEB_UFR2_FILE}"
	(gzip -d < "${TOP_DIR}/Documents/guide-ufr2-2.9xUS.tar.gz" | tar xf -) \
		|| die "untar failed for ${TOP_DIR}/Documents/guide-ufr2-2.9xUS.tar.gz"
}

src_install() {
	keepdir /etc/cngplp/account/

	dobin usr/bin/*

	local docdir="${D}/usr/share/doc/${PF}"
	dodir /usr
	dodir "/usr/share/doc/${PF}/html"
	cp -R usr/include usr/share "${D}/usr" || die "cp -R failed"
	mv "${D}/usr/share/doc/cndrvcups-common" "${docdir}" \
		|| die "renaming the doc directory failed"
	cp "${TOP_DIR}/Documents/"*.txt "${docdir}" \
		|| die "copying to the renamed doc directory failed"
	cp -R guide-ufr2-2.9xUS/* "${docdir}/html/." \
		|| die "copying the guide to the renamed doc directory failed"

	dolib.a usr/lib/*.{a,la}
	dolib.so usr/lib/*.{so,so.*}

	local cupsexec="/usr/libexec/cups/"
	for subdir in backend filter; do
		dodir "${cupsexec}${subdir}"
		exeinto "${cupsexec}${subdir}"
		doexe "usr/lib/cups/${subdir}/"*
	done

	# The libtool files likely are not worth fixing; and those that
	# would be worth fixing could better be handled by building those
	# particularly libraries from source (which we have considered
	# doing and may yet do).
	prune_libtool_files
}
