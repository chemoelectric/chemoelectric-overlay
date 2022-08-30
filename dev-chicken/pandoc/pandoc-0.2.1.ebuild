# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Call upon Pandoc to parse documents into SXML"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	virtual/pandoc:=
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/cjson:=
	dev-chicken/http-client:=
	dev-chicken/medea:=
	dev-chicken/r7rs:=
	dev-chicken/scsh-process:=
"
DEPEND="${RDEPEND}"
