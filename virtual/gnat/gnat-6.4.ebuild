# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Virtual for the gnat compiler selection"
SLOT="6.4"
KEYWORDS="~amd64 ~arm ~x86"
RDEPEND="|| (
	sys-devel/gcc:6.4.0[ada]
	sys-devel/gcc:6.4.1[ada]
	sys-devel/gcc:6.4.2[ada]
	sys-devel/gcc:6.4.3[ada]
	sys-devel/gcc:6.4.4[ada]
	sys-devel/gcc:6.4.5[ada]
	sys-devel/gcc:6.4.6[ada]
	sys-devel/gcc:6.4.7[ada]
	sys-devel/gcc:6.4.8[ada]
	sys-devel/gcc:6.4.9[ada]
	dev-lang/gnat-gcc:${PV}
)"
