# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Virtual for the gnat compiler selection"
SLOT="4.9"
KEYWORDS="~amd64 ~arm ~x86"
RDEPEND="|| (
	sys-devel/gcc:4.9.3[ada]
	sys-devel/gcc:4.9.4[ada]
	sys-devel/gcc:4.9.5[ada]
	sys-devel/gcc:4.9.6[ada]
	sys-devel/gcc:4.9.7[ada]
	sys-devel/gcc:4.9.8[ada]
	sys-devel/gcc:4.9.9[ada]
	dev-lang/gnat-gcc:${PV}
)"
