# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Markdown to Gemini text"

LICENSE="AGPL-3+"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/anaphora:=
	dev-chicken/define-options:=
	dev-chicken/lowdown:=
	dev-chicken/matchable:=
	dev-chicken/srfi1:=
	dev-chicken/sxml-transforms:=
	dev-chicken/sxpath:=
	dev-chicken/utf8:=
	dev-chicken/srfi42:=
	dev-chicken/srfi69:=
	dev-chicken/strse:=
	dev-chicken/uri-common:=
"
DEPEND="${RDEPEND}"
