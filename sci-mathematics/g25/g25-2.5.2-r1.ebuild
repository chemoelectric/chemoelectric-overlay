# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit rpm

DESCRIPTION="Gaigen 2.5, a code generator for geometric algebra"
HOMEPAGE="http://g25.sourceforge.net/"
SRC_URI="binary? ( mirror://sourceforge/${PN}/${P}-1.noarch.rpm )
	     !binary? ( mirror://sourceforge/${PN}/${P}.tar.gz )"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE="binary"

DEPEND=""
RDEPEND=">=dev-lang/mono-2.10.5"

S="${WORKDIR}"

src_compile() {
	if ! use binary; then
		cd "${P}"
		export MONO_IOMAP=all # makes mono tools case/slash insensitive
		cd g25/vs2008 || die "cd g25/vs2008"
		xbuild g25.sln /p:Configuration=Release || die "xbuild g25.sln"
		cd ../../g25_diff/vs2008 || die "cd ../../g25_diff/vs2008"
		xbuild g25_diff.csproj /p:Configuration=Release || die "xbuild g25_diff.csproj"
		cd ../../g25_test_generator/vs2008 || die "cd ../../g25_test_generator/vs2008"
		xbuild g25_test_generator.csproj /p:Configuration=Release || die "xbuild g25_test_generator.csproj"
	fi
}

src_install() {
	local datadir bindir

	if use binary; then
		cp -r usr "${D}" || die "recursive copy failed"
		dodoc usr/share/g25/doc/g25_user_manual.pdf
		rm -f "${D}"usr/share/doc/g25_user_manual.pdf
		dosym /usr/share/doc/${PF}/g25_user_manual.pdf /usr/share/g25/doc/g25_user_manual.pdf
	else
		datadir=/usr/share/
		bindir=/usr/bin/

		cd "${P}"

		insinto ${datadir}g25/bin
		doins g25/vs2008/bin/Release/g25.exe
		doins g25/vs2008/bin/Release/*.dll
		doins g25/Antlr3.Runtime.dll
		doins g25/antlr-runtime-3.2.jar
		doins g25_diff/vs2008/bin/Release/g25_diff.exe
		doins g25_test_generator/vs2008/bin/Release/g25_test_generator.exe
		doins g25_copy_resource/vs2008/bin/Release/g25_copy_resource.exe

		dodoc manual/g25_user_manual.pdf
		dosym /usr/share/doc/${PF}/g25_user_manual.pdf /usr/share/g25/doc/g25_user_manual.pdf

		doman g25/g25.1 g25/g25_test_generator.1

		cd "${S}"
		echo mono "${ROOT}"usr/share/g25/bin/g25.exe '"$@"' >> g25
		echo mono "${ROOT}"usr/share/g25/bin/g25_diff.exe '"$@"' >> g25_diff
		echo mono "${ROOT}"usr/share/g25/bin/g25_test_generator.exe '"$@"' >> g25_test_generator
		echo mono "${ROOT}"usr/share/g25/bin/g25_copy_resource.exe '"$@"' >> g25_copy_resource
		dobin g25 g25_diff g25_test_generator g25_copy_resource
	fi
}
