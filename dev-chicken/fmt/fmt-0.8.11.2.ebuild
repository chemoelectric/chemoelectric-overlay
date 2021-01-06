# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Combinator Formatting"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/srfi69:=
	dev-chicken/utf8:=
"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	# FIXME:
	#
	# *** Skip the following, to avoid confusing chicken-update.
	#
	# chicken-install (from chicken-5.2.0) does not like n.n.n.n
	# versions.  Pretend we are version 0.8.11.
	#chicken-egg_add_missing_version_to_egg_file fmt.egg 0.8.11
}
