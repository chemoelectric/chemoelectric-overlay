# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

HOMEPAGE="https://bitbucket.org/sortsmill/${PN}"

[[ -z "${SORTSMILL_NEED_GNULIB}" ]] && SORTSMILL_NEED_GNULIB=no
[[ -z "${SORTSMILL_NEED_CHANGELOGGER}" ]] && SORTSMILL_NEED_CHANGELOGGER=yes

if [[ ${PV} == 9999* ]]; then
	case "${SORTSMILL_REPO_TYPE}" in
		hg)
			EHG_REPO_URI="https://bitbucket.org/sortsmill/${PN}"
			inherit mercurial
			SRC_URI=""
			;;
		git)
			EGIT_REPO_URI="https://bitbucket.org/sortsmill/${PN}"
			inherit git-r3
			SRC_URI=""
			;;
		'')
			die "You must set SORTSMILL_REPO_TYPE"
			;;
		*)
			die "Unsupported SORTSMILL_REPO_TYPE: \`${SORTSMILL_REPO_TYPE}'"
			;;
	esac
else
	SRC_URI="mirror://sourceforge/sortsmill/${PN}/${P}.tar.xz"
fi

inherit eutils autotools

RDEPEND=""
DEPEND=""
if [[ ${PV} == 9999* ]]; then
	if [[ x"${SORTSMILL_NEED_GNULIB}" == xyes ]]; then
		DEPEND+=" >=dev-libs/gnulib-9999"
	fi
	if [[ x"${SORTSMILL_NEED_CHANGELOGGER}" == xyes ]]; then
		DEPEND+=" dev-util/sortsmill-changelogger"
	fi
fi

EXPORT_FUNCTIONS src_prepare src_configure src_install

sortsmill_src_prepare() {
	if [[ ${PV} == 9999* ]]; then
		eapply_user
		[[ x"${SORTSMILL_NEED_GNULIB}" == xyes ]] && \
			gnulib-tool --update
		eautoreconf
	else
		default
	fi
}

sortsmill_src_configure() {
	econf --docdir="/usr/share/doc/${PF}"
}

sortsmill_src_install() {
	if [[ ${PV} == 9999* ]] &&
		[[ x"${SORTSMILL_NEED_CHANGELOGGER}" == xyes ]] &&
		make -n dist-changelog distdir='.' 2>/dev/null >/dev/null; then
		if ! make dist-changelog distdir='.'; then
			ewarn "\`make dist-changelog distdir=.' failed; the ChangeLog was not remade."
			ewarn "To get a ChangeLog you might need to reconfigure sortsmill-changelogger"
			ewarn "with USE=${SORTSMILL_REPO_TYPE}."
		fi
	fi
	emake install DESTDIR="${D}"
	for f in AUTHORS ChangeLog NEWS README; do
		[[ -f "${f}" ]] && dodoc "${f}"
	done
}
