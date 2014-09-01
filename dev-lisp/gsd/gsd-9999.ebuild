# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit common-lisp-2 git-2

DESCRIPTION="Grid Structured Data library."
HOMEPAGE="http://common-lisp.net/project/gsll/"
EGIT_REPO_URI="git://repo.or.cz/gsd.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-lisp/cffi-0.10.5
		dev-lisp/trivial-garbage
		dev-lisp/fsbv
		dev-lisp/asdf-system-connections
		dev-lisp/iterate
		dev-lisp/alexandria
		dev-lisp/lisp-unit"

CLSYSTEMS="
	foreign-array/foreign-array
	foreign-array/foreign-array-tests
	grid/grid
	grid/grid-tests
"

src_install() {
	common-lisp-install foreign-array grid
	common-lisp-symlink-asdf
	use doc && dohtml -r documentation/grid
}
