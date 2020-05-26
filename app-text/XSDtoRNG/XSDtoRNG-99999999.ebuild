# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="XSL stylesheet for XML Schema (XSD) to Relax NG (RNG) conversion"
HOMEPAGE="https://github.com/epiasini/xsdtorng"
EGIT_REPO_URI="https://github.com/epiasini/XSDtoRNG.git"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64"
IUSE="+script examples"

RDEPEND="
	script? ( dev-libs/libxslt:* )
"

my_pkgsharedir() {
	echo -n "/usr/share/${PN}"
}

src_install() {
	insinto "$(my_pkgsharedir)"
	doins "xsdtorngconverter/${PN}.xsl"

	if use script; then
		cat > "${T}/${PN}" <<EOF || die
#!/bin/sh
exec /usr/bin/xsltproc "$(my_pkgsharedir)/${PN}.xsl" \${1+"\$@"}
EOF
		dobin "${T}/${PN}"
	fi

	einstalldocs
	if use examples; then
		dodoc -r examples
	fi
}
