# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator

THE_YEAR="$(get_major_version)"
THE_PACKAGE="gnat-gpl-${THE_YEAR}-x86_64-linux-bin"
THE_INSTALLATION="/opt/gnat-gpl-${THE_YEAR}"

DESCRIPTION="GNAT Ada binaries from AdaCore"
HOMEPAGE="http://libre.adacore.com"
SRC_URI="
	amd64? ( http://mirrors.cdn.adacore.com/art/5739cefdc7a447658e0b016b ->
			 	${THE_PACKAGE}.tar.gz )
"

LICENSE="GPL-2 GPL-3"
SLOT="${THE_YEAR}"
KEYWORDS="-* amd64"
IUSE="examples"

RESTRICT="strip test"

# FIXME: Find and list any other dependencies.
DEPEND=""
RDEPEND="
	sys-libs/ncurses:5
"

S="${WORKDIR}/${THE_PACKAGE}"

src_prepare() {
	eapply "${FILESDIR}/${PVR}"
	eapply_user
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	local ins_target="ins-basic"
	use examples && ins_target="ins-all"
	emake ${ins_target} \
		  prefix="${D}${THE_INSTALLATION}" \
		  realprefix="${THE_INSTALLATION}"
	for d in lib lib64 ; do
		find "${D}${THE_INSTALLATION}/${d}" -name '*.la' -delete || die
	done

	einstalldocs

	local docdir="/usr/share/doc/${PF}"
	dodir "${docdir}"
	ln -r -s \
	   "${D}${THE_INSTALLATION}"/share/doc/* \
	   "${D}${docdir}" || die

	use examples && {
		ln -r -s \
		   "${D}${THE_INSTALLATION}"/share/examples \
		   "${D}${docdir}" || die
	}

	# Put the nine's-complement of the version year in the env.d
	# file's name, so later years are favored over earlier ones.
	local version_complement=$(echo $(( 9999 - ${THE_YEAR} )))
	local envd_name="99${version_complement}${PN}"
	cat > "${T}/${envd_name}" <<-EOF
		PATH="${THE_INSTALLATION}/bin"
		ROOTPATH="${THE_INSTALLATION}/bin"
		MANPATH="${THE_INSTALLATION}/share/man"
		INFOPATH="${THE_INSTALLATION}/share/info"
	EOF
	doenvd "${T}/${envd_name}"
}

pkg_postinst() {
	elog "GNAT GPL ${PV} has been installed into ${THE_INSTALLATION}"
	elog "but ${THE_INSTALLATION}/bin has been put near the"
	elog "*end* of the default PATH, so as not to interfere"
	elog "with the system compiler and other commands."
	elog ""
	elog "If you want to use GNAT GPL ${PV} as your *user* toolset,"
	elog "you may put ${THE_INSTALLATION}/bin earlier in your PATH."
}
