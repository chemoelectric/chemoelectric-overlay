# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Posix bindings for Ada"
HOMEPAGE="http://libre.adacore.com/"
SRC_URI="http://mirrors.cdn.adacore.com/art/57399229c7a447658e0aff79 -> florist-gpl-2016-src.tar.gz"

LICENSE="GPL-2+ GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="threads"

RDEPEND="virtual/ada:*"
DEPEND="${RDEPEND} dev-ada/gprbuild:*"

S="${WORKDIR}/${PN}-gpl-${PV}-src"

# FIXME: Get shared library builds to work.

# FIXME: Make a copy of the sources and build both shared and static
# libraries.

src_configure() {
	econf --disable-shared $(use_enable threads)
}

src_install() {
	emake install PREFIX="${D}/usr"
	einstalldocs
}
