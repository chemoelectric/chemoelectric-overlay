# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils git-2

DESCRIPTION="Etckeeper is a collection of tools to let /etc be stored in a git, mercurial, or bzr repository."
HOMEPAGE="http://kitenet.net/~joey/code/etckeeper/"

EGIT_REPO_URI="git://git.kitenet.net/etckeeper"
EGIT_COMMIT="${PV/r[0-9]*/}"

LICENSE="GPL-2"
IUSE="git mercurial bzr bash-completion"
KEYWORDS="~x86 ~amd64"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND} >=app-portage/gentoolkit-0.3.0.4-r5
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )
	bzr? ( dev-vcs/bzr )
	bash-completion? ( app-shells/bash-completion ) "

src_unpack() {
	git-2_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/${P}.patch" || die "Failed to patch"
}

src_compile() {
	if use bzr; then
		emake || die "make failed : problem in support python for bzr"
	fi
}

src_install() {

	emake DESTDIR="${D}" install || die "make install failed"

	if use bash-completion; then
		install -m 0644 -D bash_completion "${D}/etc/bash_completion.d/etckeeper"
	fi

	if use bzr; then
		./etckeeper-bzr/__init__.py install --root="${D}" || die "Error: bzr support installation"
	fi

	mkdir -p "${D}/etc/portage/"
	cp "${FILESDIR}/autocommit" "${D}/etc/portage/etckeeper" || die "Could not copy autocommit script"
	chmod 755 "${D}/etc/portage/etckeeper"
}

pkg_postinst() {
	elog "If you want etckeeper to automatically commit"
	elog "Add this to your ${ROOT}/etc/portage/bashrc"
	elog "source /etc/portage/etckeeper"
}
