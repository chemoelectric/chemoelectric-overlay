# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Common Lisp the Language, 2nd Edition"
HOMEPAGE="http://www.cs.cmu.edu/Groups/AI/html/cltl/cltl2.html"
SRC_URI="
	html? ( http://www.cs.cmu.edu/afs/cs.cmu.edu/project/ai-repository/ai/lang/lisp/doc/cltl/cltl_ht.tgz ->
			${PN}-html-2.tar.gz )
	pdf? ( http://www.cs.cmu.edu/afs/cs.cmu.edu/project/ai-repository/ai/lang/lisp/doc/cltl/cltl_ps.tgz ->
			${PN}-ps-2.tar.gz )
"

# FIXME: Add LICENSE.
LICENSE=""

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+html pdf"
REQUIRED_USE="|| ( html pdf )"

DEPEND="pdf? ( app-text/ghostscript-gpl )"
RDEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	use html && {
		newdoc README{,-html}
		dohtml *.html
		cp -R clm/ digital_press/ \
			"${ED}"/usr/share/doc/"${PF}"/html/ || die "cp -R failed"
	}

	use pdf && {
		pushd "${WORKDIR}"/cltl_ps
		newdoc README{,-pdf}
		ps2pdf clm.ps
		dodoc clm.pdf
		popd
	}
}
