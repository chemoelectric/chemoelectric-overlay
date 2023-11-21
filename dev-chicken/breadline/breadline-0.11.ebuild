# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="CHICKEN Scheme bindings to readline"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/apropos:=
	dev-chicken/srfi18:=
	sys-libs/readline:=
"
DEPEND="${RDEPEND}"

src_install() {
	chicken-egg_src_install

	cp -R examples "${T}/examples" || die
	if [[ -e "${T}/examples/.csirc" ]]; then
		mv "${T}/examples/.csirc" \
		   "${T}/examples/sample.csirc" || die
	else
		cp "${FILESDIR}/sample.csirc" \
		   "${T}/examples/sample.csirc" || die
	fi
	dodoc -r "${T}/examples"
}
