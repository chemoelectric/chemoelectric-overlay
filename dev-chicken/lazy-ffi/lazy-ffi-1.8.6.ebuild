# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A foreign function interface for lazy programmers"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libffi:=
	>=dev-scheme/chicken-5.3.0_rc4:=
	dev-chicken/bind:=
	dev-chicken/srfi1:=
	dev-chicken/srfi69:=
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig:*"

PATCHES=( "${FILESDIR}"/"${PN}"-1.8.6-c-include-path.patch )

src_prepare()
{
	local include_path=`pkg-config --cflags libffi | sed 's/[ 	]-I/-C -I/g;s/^-I/-C -I/'`
	default
	sed -i -e "s|@LIBFFI_INCLUDE@|${include_path}|" \
		lazy-ffi.egg || die
}
