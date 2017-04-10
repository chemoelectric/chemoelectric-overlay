# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Virtual for the gnat compiler selection"
SLOT="6.3"
KEYWORDS="~amd64 ~arm ~x86"
RDEPEND="|| (
	sys-devel/gcc:6.3.0[ada]
	sys-devel/gcc:6.3.1[ada]
	sys-devel/gcc:6.3.2[ada]
	sys-devel/gcc:6.3.3[ada]
	sys-devel/gcc:6.3.4[ada]
	sys-devel/gcc:6.3.5[ada]
	sys-devel/gcc:6.3.6[ada]
	sys-devel/gcc:6.3.7[ada]
	sys-devel/gcc:6.3.8[ada]
	sys-devel/gcc:6.3.9[ada]
	dev-lang/gnat-gcc:${PV}
)"
