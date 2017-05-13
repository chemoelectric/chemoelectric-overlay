# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Virtual for the gnat compiler selection"
SLOT="7.1"
KEYWORDS="~amd64 ~arm ~x86"
RDEPEND="|| (
	sys-devel/gcc:7.1.0[ada]
	sys-devel/gcc:7.1.1[ada]
	sys-devel/gcc:7.1.2[ada]
	sys-devel/gcc:7.1.3[ada]
	sys-devel/gcc:7.1.4[ada]
	sys-devel/gcc:7.1.5[ada]
	sys-devel/gcc:7.1.6[ada]
	sys-devel/gcc:7.1.7[ada]
	sys-devel/gcc:7.1.8[ada]
	sys-devel/gcc:7.1.9[ada]
	dev-lang/gnat-gcc:${PV}
)"
