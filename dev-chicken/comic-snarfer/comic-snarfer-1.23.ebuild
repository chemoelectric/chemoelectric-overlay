# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Download files (such as web comic images) by recursing on XPath"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/anaphora:=
	dev-chicken/brev-separate:=
	dev-chicken/define-options:=
	dev-chicken/http-client:=
	dev-chicken/html-parser:=
	dev-chicken/mathh:=
	dev-chicken/srfi42:=
	dev-chicken/sxpath:=
	dev-chicken/strse:=
	dev-chicken/uri-generic:=
"
DEPEND="${RDEPEND}"
