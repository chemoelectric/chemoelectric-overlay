# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils multilib perl-functions multilib-minimal

# cvs -d anoncvs@anoncvs.openbsd.org:/cvs get src/usr.bin/pkg-config

PKG_M4_VERSION=0.29.2

DESCRIPTION="A perl based version of pkg-config from OpenBSD"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/src/usr.bin/pkg-config/"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${P}.tar.xz
	pkg-config? ( http://pkgconfig.freedesktop.org/releases/pkg-config-${PKG_M4_VERSION}.tar.gz )"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pkg-config"

RDEPEND="
	dev-lang/perl:=
	virtual/perl-Getopt-Long:=
	pkg-config? (
		!dev-util/pkgconfig
		!dev-util/pkgconf[pkg-config]
	)"

S=${WORKDIR}/src

src_prepare() {
	eapply_user
	ecvs_clean

	# Config.pm from dev-lang/perl doesn't set ARCH, only archname
	sed -i -e '/Config/s:ARCH:archname:' usr.bin/pkg-config/pkg-config || die

	if use pkg-config; then
		MULTILIB_CHOST_TOOLS=( /usr/bin/pkg-config )
	else
		MULTILIB_CHOST_TOOLS=( /usr/bin/pkg-config-openbsd )
	fi
}

multilib_src_configure() {
	default
	use pkg-config && multilib_is_native_abi && {
		# This is a tedious way to get pkg.m4, but seems safest.
		pushd "${WORKDIR}"/pkg-config-* || die
		econf --with-internal-glib
		popd || die
	}
}

multilib_src_compile() {
	default
	use pkg-config && multilib_is_native_abi &&
		emake -C "${WORKDIR}"/pkg-config-* pkg.m4
}

multilib_src_install() {
	local pc_bin=pkg-config
	use pkg-config || pc_bin+=-openbsd

	newbin "${S}"/usr.bin/pkg-config/pkg-config ${pc_bin}
	newman "${S}"/usr.bin/pkg-config/pkg-config.1 ${pc_bin}.1

	# insert proper paths
	local pc_paths=(
		/usr/$(get_libdir)/pkgconfig
		/usr/share/pkgconfig
	)
	sed -i -e "/my @PKGPATH/,/;/{s@(.*@( ${pc_paths[*]} );@p;d}" \
		"${ED%/}/usr/bin/${pc_bin}" || die
}

multilib_src_install_all() {
	if use pkg-config; then
		insinto /usr/share/aclocal
		doins "${WORKDIR}"/pkg-config-*/pkg.m4
	fi

	perl_set_version
	insinto "${VENDOR_LIB}"
	doins -r "${S}"/usr.bin/pkg-config/OpenBSD
}
