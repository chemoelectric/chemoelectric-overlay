# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit elisp-common

DESCRIPTION="Emacs mode for the ATS2 Programming Language"
HOMEPAGE="http://www.ats-lang.org"

ATS2_MODE_PV_LIVE="99999999"

if [[ "${PV}" = "${ATS2_MODE_PV_LIVE}" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.code.sf.net/p/ats2-lang/code"
	DO_AUTOTOOLS=yes
else
	SRC_URI_PREFIX="mirror://sourceforge/ats2-lang/ats2-lang/${PN}-postiats-${PV}/ATS2-Postiats-"
	if ver_test -ge 0.4.0; then
		SRC_URI_PREFIX="${SRC_URI_PREFIX}gmp-"
	fi
	SRC_URI="${SRC_URI_PREFIX}${PV}.tgz"
	DO_AUTOTOOLS=no
fi

LICENSE="GPL-3"
IUSE=""

RDEPEND="app-editors/emacs:*"
DEPEND="${RDEPEND}"

if ver_test -ge 0.3.13; then
	S="${WORKDIR}/ATS2-Postiats-gmp-${PV}"
else
	S="${WORKDIR}/ATS2-Postiats-${PV}"
fi

EXPORT_FUNCTIONS src_unpack src_prepare src_configure src_compile src_install

ats2-mode_src_unpack() {
	if [[ "${PV}" == "${ATS2_MODE_PV_LIVE}" ]]; then
		git-r3_fetch "${EGIT_REPO_URI}"
		git-r3_checkout "${EGIT_REPO_URI}" "${S}"
	else
		default
	fi
}

ats2-mode_src_prepare() {
	default
	case "${EAPI:-0}" in
		0 | 1 | 2 | 3 | 4) die "EAPI ${EAPI} is not supported." ;;
		5) epatch_user ;;
		*) : ;;
	esac
}

ats2-mode_src_configure() {
	:
}

ats2-mode_src_compile() {
	einfo "Compiling emacs lisp files"
	elisp-compile "utils/emacs/${PN}.el" || die "elisp-compile failed"
}

ats2-mode_src_install() {
	dodoc AUTHORS CHANGES*
	dodoc -r RELEASE

	pushd "utils/emacs" > /dev/null
	elisp-install "${PN}" "${PN}.el" "${PN}.elc" || die "elisp-install failed"
	cat > "50${PN}-gentoo.el" <<EOF
;; site-init for dev-lang/${PN}
(add-to-list 'load-path "@SITELISP@")
EOF
	elisp-site-file-install "50${PN}-gentoo.el"
	popd > /dev/null
}
