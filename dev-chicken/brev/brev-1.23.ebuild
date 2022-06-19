# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="A huge pile of batteries and shortcuts"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/anaphora:=
	dev-chicken/brev-separate:=
	dev-chicken/clojurian:=
	dev-chicken/combinators:=
	dev-chicken/define-options:=
	dev-chicken/html-parser:=
	dev-chicken/match-generics:=
	dev-chicken/http-client:=
	dev-chicken/matchable:=
	dev-chicken/miscmacros:=
	dev-chicken/scsh-process:=
	dev-chicken/srfi1:=
	dev-chicken/srfi42:=
	dev-chicken/srfi69:=
	dev-chicken/strse:=
	dev-chicken/sxml-serializer:=
	dev-chicken/sxml-transforms:=
	dev-chicken/sxpath:=
	dev-chicken/tree:=
	dev-chicken/uri-common:=
"
DEPEND="${RDEPEND}"
