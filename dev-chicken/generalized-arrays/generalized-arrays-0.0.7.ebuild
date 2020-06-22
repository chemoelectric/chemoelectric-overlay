# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit chicken-egg

DESCRIPTION="Generalized arrays and storage classes for CHICKEN Scheme"

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.2.0:=
	dev-chicken/check-errors:=
	dev-chicken/matchable:=
	dev-chicken/srfi133:=
	dev-chicken/typed-records:=
"
DEPEND="${RDEPEND}"
