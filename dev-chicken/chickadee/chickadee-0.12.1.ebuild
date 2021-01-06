# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="chicken-doc web server"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/matchable:=
	dev-chicken/uri-common:=
	>=dev-chicken/uri-generic-3.2:=
	dev-chicken/intarweb:=
	dev-chicken/simple-sha1:=
	>=dev-chicken/spiffy-6.2:=
	dev-chicken/spiffy-request-vars:=
	dev-chicken/sxml-transforms:=
	>=dev-chicken/chicken-doc-0.6.0:=
	>=dev-chicken/chicken-doc-admin-0.5.0:=
	>=dev-chicken/chicken-doc-html-0.3.0:=
	dev-chicken/srfi18:=
"
DEPEND="${RDEPEND}"
