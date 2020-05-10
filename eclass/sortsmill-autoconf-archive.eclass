# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

SORTSMILL_REPO_TYPE=git

inherit sortsmill

DESCRIPTION="Sorts Mill Autoconf Archive"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"

IUSE=""
LICENSE="GPL-3+ GNUAllPermissive"
