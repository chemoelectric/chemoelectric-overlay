# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2
inherit java-pkg-simple

DESCRIPTION="Multi-Schema XML Validator, a Java tool for validating XML documents"
HOMEPAGE="https://github.com/xmlark/msv"
SRC_URI="https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/${PN}-core-2017.2-SNAPSHOT-sources.jar"
LICENSE="BSD Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

CDEPEND="
	dev-java/iso-relax:0
	dev-java/relaxng-datatype:0
	dev-java/xsdlib:0
"

RDEPEND="
	${CDEPEND}
	dev-java/xerces:2
	>=virtual/jre-1.8
"

DEPEND="
	${CDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.8
"

JAVA_GENTOO_CLASSPATH="iso-relax,relaxng-datatype,xsdlib"
JAVAC_ARGS="-XDignore.symbol.file"

src_compile() {
	java-pkg-simple_src_compile
	java-pkg_addres "${PN}.jar" . ! -path "*/doc-files/*" ! -name "*.html"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_register-dependency xerces-2
	java-pkg_dolauncher "${PN}" --main com.sun.msv.driver.textui.Driver
}
