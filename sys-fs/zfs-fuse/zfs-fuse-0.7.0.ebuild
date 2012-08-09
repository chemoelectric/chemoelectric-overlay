# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit scons-utils toolchain-funcs eutils

DEBIAN_V=8

DESCRIPTION="ZFS-FUSE: a port of the ZFS file system from Sun"
HOMEPAGE="http://zfs-fuse.net/"
SRC_URI="mirror://debian/pool/main/z/${PN}/${PN}_${PV}.orig.tar.bz2
         mirror://debian/pool/main/z/zfs-fuse/${PN}_${PV}-${DEBIAN_V}.debian.tar.gz
         http://hub.opensolaris.org/bin/download/Community+Group+zfs/docs/zfsadmin.pdf -> ${P}-zfsadmin.pdf
         http://hub.opensolaris.org/bin/download/Community+Group+zfs/docs/ondiskformat0822.pdf -> ${P}-ondiskformat0822.pdf"
LICENSE="CDDL"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-libs/openssl-1.0.0j
         >=dev-libs/libaio-0.3.109-r2"
DEPEND=">=sys-fs/fuse-2.8.6
        ${RDEPEND}"

S="${WORKDIR}/${P}/src"

src_unpack() {
	default
	for doc in zfsadmin.pdf ondiskformat0822.pdf; do
		cp "${DISTDIR}/${P}-${doc}" "${WORKDIR}/${doc}" \
			|| die "could not copy ${doc}"
	done
}

src_prepare() {
	local debian_patches="${WORKDIR}/debian/patches"

	pushd "${WORKDIR}/${P}"
	for patch in $(cat "${debian_patches}/series"); do
		epatch "${debian_patches}/${patch}"
	done
	epatch "${FILESDIR}/zfs-fuse-0.7.0-__MALLOC_HOOK_VOLATILE.patch"
	popd
}

src_configure() {
	myesconsargs=(
		debug=1
		optim=-O2
    )
}

src_compile() {
    escons
}

src_install() {
    escons \
		cfg_dir="${D}"etc/zfs \
		install_dir="${D}"usr/sbin \
		man_dir="${D}"usr/share/man/man8 \
		install

	pushd "${WORKDIR}/${P}"
	dodoc BUGS README TESTING CHANGES HACKING
	dodoc README.NFS STATUS TODO zfs-fuse.spec
	popd

	for doc in zfsadmin.pdf ondiskformat0822.pdf; do
		dodoc "${WORKDIR}/${doc}"
	done
}
