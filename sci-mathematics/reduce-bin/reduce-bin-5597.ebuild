# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit elisp-common

DESCRIPTION="A general-purpose computer algebra system (binary installation)"
HOMEPAGE="https://reduce-algebra.sourceforge.io/"
SRC_URI="mirror://sourceforge/reduce-algebra/snapshot_2021-01-18/linux64/reduce-complete_5597_amd64.tgz"

SLOT="0"
LICENSE="BSD-2 LGPL-2.1"
KEYWORDS="~amd64"

#
#      FIXME: Emacs support currently is broken. It seems to be
#             tailored for Debian. Fix the startup file!
#

#IUSE="emacs"
IUSE=""

RDEPEND="
	x11-libs/libXrandr:=
	x11-libs/libXcursor:=
	x11-libs/libXft:=
"
#	emacs? ( app-editors/emacs:= )
DEPEND="${RDEPEND}"

RESTRICT=test

QA_PREBUILT="
	opt/${PF}/usr/bin/rfpsl
	opt/${PF}/usr/bin/rfcsl
	opt/${PF}/usr/lib/reduce/cslbuild/csl/bootstrapreduce
	opt/${PF}/usr/lib/reduce/cslbuild/csl/csl
	opt/${PF}/usr/lib/reduce/cslbuild/csl/reduce
	opt/${PF}/usr/lib/reduce/pslbuild/psl/bpsl
"
QA_WX_LOAD="
	opt/${PF}/usr/lib/reduce/pslbuild/psl/bpsl
"

S="${WORKDIR}"

src_prepare() {
	default
	find usr -type d -exec touch '{}'/.keep ';' || die
}

src_configure() {
	:
}

src_compile() {
	:
#	if use emacs; then
#		elisp-compile "usr/share/emacs/site-lisp/reduce/reduce-mode.el"
#	fi
}

src_install() {
	local optdir=opt/"${PF}"

	mkdir -p "${D}/${optdir}" || die
	cp -R usr "${D}/${optdir}/." || die

	for f in usr/bin/*; do
		dosym ../../"${optdir}"/"${f}" /"${f}"
	done

	dosym ../../"${optdir}"/usr/share/reduce /usr/share/reduce
	dosym ../../"${optdir}"/usr/share/reduce-addons /usr/share/reduce-addons

	# FIXME: This really should have some things located in other
	# ‘lib’ directories.
	dosym ../../"${optdir}"/usr/lib/reduce /usr/lib/reduce

	pushd usr/share/man/man1/ 2>/dev/null || die
	for f in *; do
		gzip -d < "${f}" > "${T}/${f/.gz/}" || die
		doman "${T}/${f/.gz/}"
	done
	popd 2>/dev/null || die

	mkdir -p "${D}"/usr/share/doc/"${PF}" || die
	pushd usr/share/doc 2>/dev/null || die
	for f in *; do
		dosym ../../../../"${optdir}"/usr/share/doc/"${f}" \
			  /usr/share/doc/"${PF}"/"${f}"
	done
	popd 2>/dev/null || die

#	if use emacs; then
#		elisp-install "${PN}" usr/share/emacs/site-lisp/reduce/reduce-mode.el{,c}
#		cp etc/emacs/site-start.d/50reduce-emacs.el "${T}"/50"${PN}"-gentoo.el || die
#		elisp-site-file-install "${T}"/50"${PN}"-gentoo.el
#	fi
}
