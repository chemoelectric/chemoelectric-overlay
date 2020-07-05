# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Goaldi: A Goal-Directed Programming Language"
HOMEPAGE="https://github.com/proebsting/goaldi"
EGIT_REPO_URI="https://github.com/proebsting/goaldi.git"

LICENSE="goaldi"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-lang/go:="
DEPEND="${RDEPEND}"

# FIXME: add IUSE=doc to build the documentation.
IUSE=""

gopath() {
	echo "${T}/gopath"
}

binpath() {
	echo "$(gopath)/bin"
}

srcpath() {
	echo "$(gopath)/src"
}

goaldi_path() {
	echo "$(srcpath)/goaldi"
}

run_command() {
	cd "$(goaldi_path)" || die
	env GOPATH="$(gopath)" \
		PATH="$(binpath):${PATH}" \
		"${@}"
}

src_prepare() {
	eapply_user
	mkdir -p "$(binpath)" "$(srcpath)" || die
	ln -sv "${WORKDIR}/${P}" "$(goaldi_path)" || die

	# FIXME: this is not ideal.
	cp -R doc demos tests "${T}" || die
}

src_compile() {
	run_command make boot || die
	run_command make goaldi || die
}

src_test() {
	run_command make test || die
}

src_install() {
	dobin goaldi

	# FIXME: this is not ideal.
	dodoc README.adoc
	(cd "${T}" && dodoc -r doc demos tests) || die
}
