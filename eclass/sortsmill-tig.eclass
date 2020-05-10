# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

SORTSMILL_REPO_TYPE=git
SORTSMILL_NEED_GNULIB=no

inherit sortsmill

DESCRIPTION="Sorts Mill Type Inspector Generator"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"

IUSE=""
LICENSE="GPL-3+"

GUILE_DEPENDENCIES=">=dev-scheme/guile-2.0.9:*"

RDEPEND+="
	${GUILE_DEPENDENCIES}
"
DEPEND+="
	${GUILE_DEPENDENCIES}
	virtual/awk
	sys-apps/help2man
"
