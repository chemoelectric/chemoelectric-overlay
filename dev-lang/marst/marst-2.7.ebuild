# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GNU MARST: an Algol-to-C translator"
HOMEPAGE="https://www.gnu.org/software/marst/marst.html"
SRC_URI="https://ftp.gnu.org/gnu/marst/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

src_install ()
{
	default
	rm -f "${ED}"/usr/"$(get_libdir)"/*.la || die
}
