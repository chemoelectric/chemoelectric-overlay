# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

SORTSMILL_REPO_TYPE=git
SORTSMILL_NEED_GNULIB=no

inherit sortsmill

DESCRIPTION="Sorts Mill Changelogger"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"

IUSE="+mercurial bzr +git"
LICENSE="GPL-3+"

_VCS_DEPEND="
	mercurial? ( dev-vcs/mercurial )
	bzr? ( dev-vcs/bzr )
	git? ( dev-vcs/git dev-lang/perl )
"

RDEPEND+=" ${_VCS_DEPEND}"
DEPEND+=" ${_VCS_DEPEND} sys-apps/help2man"
