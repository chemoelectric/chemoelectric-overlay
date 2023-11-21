# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chicken-egg

DESCRIPTION="Simple hahn-style in-source documentation"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-scheme/chicken-5.3.0:=
	dev-chicken/srfi1:=
	dev-chicken/srfi13:=
	dev-chicken/getopt-long:=
"
DEPEND="${RDEPEND}"

src_prepare()
{
	chicken-egg_src_prepare

	# The reader that comes with chalk seems to clash with items we have
	# installed here at the Crud Factory. Use our modified reader,
	# instead.
	echo cp "${FILESDIR}/chalk.scm" chalk.scm
	cp "${FILESDIR}/chalk.scm" chalk.scm || die
}
