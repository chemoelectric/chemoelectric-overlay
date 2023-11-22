# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Unix filter that turns XML into JSON"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/fmt:=
	dev-chicken/html-parser:=
	dev-chicken/srfi1:=
	dev-chicken/utf8:=
	dev-chicken/brev-separate:=
"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/gzip"

src_prepare()
{
	chicken-egg_src_prepare
	gzip -d xj.1.gz || die
}

src_install()
{
	chicken-egg_src_install
	doman xj.1
}
