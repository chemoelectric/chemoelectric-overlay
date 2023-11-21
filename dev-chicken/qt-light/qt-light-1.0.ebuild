# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="A lightweight Qt 5 interface"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/bind:=
	dev-chicken/protobj:=
	dev-chicken/matchable:=
	dev-chicken/miscmacros:=
	dev-chicken/shell:=
	dev-qt/qtopengl:5=
	dev-qt/qtwidgets:5=
	dev-qt/qtmultimedia:5=
	dev-qt/qtgui:5=
	dev-qt/qtcore:5=
	dev-qt/qtnetwork:5=
"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qtchooser:="

PATCHES=(
	"${FILESDIR}/qt-light-1.0-csc-name.patch"
)

src_compile() {
	export QTDIR="/usr"
	chicken-egg_src_compile
}

src_install() {
	chicken-egg_src_install
	use examples && dodoc -r examples
}
