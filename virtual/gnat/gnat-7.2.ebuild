# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Virtual for the gnat compiler selection"
SLOT="7.2"
KEYWORDS="~amd64 ~arm ~x86"
RDEPEND="|| (
	sys-devel/gcc:7.2.0[ada]
	sys-devel/gcc:7.2.1[ada]
	sys-devel/gcc:7.2.2[ada]
	sys-devel/gcc:7.2.3[ada]
	sys-devel/gcc:7.2.4[ada]
	sys-devel/gcc:7.2.5[ada]
	sys-devel/gcc:7.2.6[ada]
	sys-devel/gcc:7.2.7[ada]
	sys-devel/gcc:7.2.8[ada]
	sys-devel/gcc:7.2.9[ada]
	dev-lang/gnat-gcc:${PV}
)"
