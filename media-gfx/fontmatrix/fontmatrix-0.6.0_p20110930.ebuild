# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DEBIAN_VERSION="${PN}_${PV/_p*/}+svn${PV/*_p/}"
DEBIAN_PATCHLEVEL="-1.1"
DEBIAN_REPO="http://http.debian.net/debian/pool/main/f"

DESCRIPTION="A font manager"
HOMEPAGE="https://packages.debian.org/source/sid/fontmatrix"
SRC_URI="
	${DEBIAN_REPO}/${PN}/${DEBIAN_VERSION}.orig.tar.gz
	${DEBIAN_REPO}/${PN}/${DEBIAN_VERSION}${DEBIAN_PATCHLEVEL}.debian.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="
	dev-qt/qtgui:4
	dev-qt/qtsql:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	media-libs/freetype:2
"
DEPEND="
	${RPEDEND}
	dev-util/patchelf:*
"

S="${WORKDIR}/${P/_p*/}+svn20110930"
DEBIAN_STUFF="${WORKDIR}/debian"

src_prepare() {
	for p in $(cat "${DEBIAN_STUFF}"/patches/series); do
		eapply "${DEBIAN_STUFF}"/patches/"${p}"
	done
	eapply_user
}

src_configure() {
	local mycmakeargs=( "-DOWN_SHAPER=1" )
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	# The compilation generates a bad and useless DT_RUNPATH and I
	# would rather just remove the entry than fix the build
	# process. ¯\_(ツ)_/¯
	patchelf --remove-rpath "${WORKDIR}/${P}_build/src/${PN}" || die
}

src_install() {
	dobin "${CMAKE_BUILD_DIR}"/src/"${PN}"
	doman "${PN}".1
	domenu "${PN}".desktop
	doicon "${PN}".png
	dodoc ChangeLog TODO
	einstalldocs
}
