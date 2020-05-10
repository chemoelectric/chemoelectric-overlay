# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

SORTSMILL_REPO_TYPE=git
SORTSMILL_NEED_GNULIB=no

inherit eutils autotools versionator sortsmill

DESCRIPTION="a library for retrieving Unicode annotation data"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"

IUSE="nls static-libs"

# FIXME: Make this unconditional when < 1.2.0_beta1 is obsolete.
$(version_is_at_least 1.2.0_beta1) && IUSE+=" make-libunicodenames-db"

LINGUA_REPERTOIRE_SRC=":fr"
LINGUA_REPERTOIRE="${LINGUA_REPERTOIRE_SRC//:/ }"
IUSE+=" ${LINGUA_REPERTOIRE_SRC//:/l10n_}"

LICENSE="LGPL-3+"

DEPEND+=" sys-apps/sed"

# FIXME: Remove this stuff when 1.0.* is obsolete.
if [[ ${PV} == 1.0.* ]]; then
	IUSE+=" doc"
	DEPEND+=" doc? ( sys-apps/texinfo )"
fi
_want_doc() {
	[[ ${PV} == 1.0.* ]] && use doc
}

EXPORT_FUNCTIONS src_configure src_test src_install

sortsmill-libunicodenames_src_configure() {
	use nls && strip-linguas ${LINGUA_REPERTOIRE}

	local enables="\
		$(use_enable nls) \
		$(use_enable static-libs static)"

	$(version_is_at_least 1.2.0_beta1) && \
		enables+=" $(use_enable make-libunicodenames-db)"

	econf --docdir="/usr/share/doc/${PF}" ${enables}
}

sortsmill-libunicodenames_src_test() {
	emake check
}

sortsmill-libunicodenames_src_install() {
	local format

	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README
	if _want_doc; then
		for format in html pdf ps dvi; do
			emake install-${format} DESTDIR="${D}" \
				MAKEINFOFLAGS="--no-split"
		done
	fi
}
