# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GENTOO_DEPEND_ON_PERL="no"
inherit toolchain-funcs perl-module eutils versionator autotools
inherit multilib-minimal

MAJOR=$(get_major_version)
MY_PV=$(get_version_component_range 1-3)
MY_P=${PN}-${MY_PV}
DEB_PV=$(replace_version_separator 3 '-')
DEB_P=${PN}_${DEB_PV}

DESCRIPTION="Library for locking devices"
HOMEPAGE="https://packages.debian.org/source/sid/lockdev"
SRC_URI="
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${MY_PV}.orig.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${DEB_P}.diff.gz
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="perl"

DEPEND="
	perl? ( dev-lang/perl )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${MY_P}-add-autotools.patch"
	"${FILESDIR}/${MY_P}-fix-perl.patch"
	"${FILESDIR}/${MY_P}-static-inline.patch"
	"${FILESDIR}/${MY_P}-symlinks.patch"
)

S="${WORKDIR}/${PN}-${MY_PV}"

using_perl() {
	multilib_is_native_abi && use perl
}

pkg_setup() {
	use perl && perl_set_version
}

src_prepare() {
	cd "${WORKDIR}" || die
	# Note: we do *not* want to be in ${S} for this, as that breaks the patch
	epatch "${WORKDIR}/${DEB_P}.diff"

	cd "${S}" || die
	epatch "${PATCHES[@]}"
	eapply_user

	eautoreconf

	multilib_copy_sources
}

multilib_src_configure() {
	econf

	if using_perl; then
		cd "LockDev" || die
		perl-module_src_configure
	fi
}

multilib_src_compile() {
	emake

	if using_perl; then
		cd "LockDev" || die
		perl-module_src_compile
	fi
}

multilib_src_test() {
	if using_perl; then
		cd "LockDev" || die
		SRC_TEST="do"
		export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}${BUILD_DIR}/.libs"
		perl-module_src_test
	fi
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	if using_perl; then
		cd "LockDev" || die
		mytargets="pure_install"
#		docinto perl
		perl-module_src_install
	fi
}

multilib_src_install_all() {
	dodoc AUTHORS ChangeLog* debian/NEWS README.debug
	newdoc debian/changelog changelog.debian

	prune_libtool_files --all
}

pkg_preinst() {
	use perl && perl_set_version
}
