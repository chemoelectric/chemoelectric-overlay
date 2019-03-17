# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Virtual for the gnat compiler selection"
SLOT="7.4"
KEYWORDS="~amd64 ~arm ~x86"
RDEPEND="|| (
	sys-devel/gcc:7.4.0[ada]
	sys-devel/gcc:7.4.1[ada]
	sys-devel/gcc:7.4.2[ada]
	sys-devel/gcc:7.4.3[ada]
	sys-devel/gcc:7.4.4[ada]
	sys-devel/gcc:7.4.5[ada]
	sys-devel/gcc:7.4.6[ada]
	sys-devel/gcc:7.4.7[ada]
	sys-devel/gcc:7.4.8[ada]
	sys-devel/gcc:7.4.9[ada]
	dev-lang/gnat-gcc:${PV}
)"
