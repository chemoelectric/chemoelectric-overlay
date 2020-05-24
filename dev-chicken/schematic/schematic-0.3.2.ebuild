# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Tools for Scheme development"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/optimism:=
	dev-chicken/r7rs:=
"
DEPEND="${RDEPEND}"

# FIXME: Is there a different converter that will work better for us?
#        Ronn does not work well. Neither go-md2man nor ronn is
#        written in Scheme or C.
BDEPEND="dev-go/go-md2man:*"

src_install() {
	chicken-egg_src_install
	dodoc CHANGELOG*

	for f in *.1.md; do
		manualname="${f/.1.md}"
		manfile="${f/.1.md/.1}"
		go-md2man -in "${f}" -out "${T}/${manfile}" || die
		doman "${T}/${manfile}"
	done
}
