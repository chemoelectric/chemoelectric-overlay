# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Industrial strength theorem prover"
HOMEPAGE="https://www.cs.utexas.edu/users/moore/acl2/"
MY_PN=${PN}-devel
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="dev-lisp/sbcl"
DEPEND="
	dev-lisp/sbcl:=
	dev-lang/perl:*
"
RDEPEND="${DEPEND}"

my_lisp() {
	echo "/usr/bin/sbcl --noinform --noprint --no-sysinit --no-userinit --disable-debugger"
}

src_compile() {
	# Build ACL2 and the basic set of books.
	emake -f GNUmakefile LISP="$(my_lisp)"
	emake -f GNUmakefile LISP="$(my_lisp)" basic
}

src_install() {
	# Change the path to the dumped core.
	sed -i -e "s:${S}:/usr/share/acl2:g" saved_acl2 || die

	# Tell ACL2 where to find the books.
	sed -i -e "/^# Saved/a\\
\\
export ACL2_SYSTEM_BOOKS=/usr/share/acl2/books/" \
		saved_acl2 || die

	# Install the script, but make it available also under the name
	# ‘acl2’.
	dobin saved_acl2
	dosym saved_acl2 /usr/bin/${PN}

	insinto /usr/share/acl2
	doins TAGS saved_acl2.core
	doins -r books
}
