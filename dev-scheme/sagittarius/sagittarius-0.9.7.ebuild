# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="R6RS/R7RS Scheme implementation"
HOMEPAGE="https://bitbucket.org/ktakashi/sagittarius-scheme/wiki/Home"
SRC_URI="https://bitbucket.org/ktakashi/sagittarius-scheme/downloads/${P}.tar.gz"
LICENSE="BSD-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-libs/boehm-gc-8.0.4:=[threads]
	>=dev-libs/libffi-3.3:=
	>=sys-libs/zlib-1.2.11:=
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/do-not-run-ldconfig.patch
)

src_configure() {
	mycmakeargs=(
		-DLIB_DIR="$(get_libdir)"
		-DPKGCONFIG_DIR="$(get_libdir)"/pkgconfig

		# Do not install the compile-r7rs command. This is the job of
		# system configuration.
		-DINSTALL_SRFI_138=OFF

		# Let Portage take care of the architectural flags.
		-DUSE_SSE=OFF
	)

	cmake_src_configure
}
