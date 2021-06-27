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
IUSE="books-all books-basic books-everything books-none"

REQUIRED_USE="
	^^ ( books-all books-basic books-everything books-none )
"

DEPEND="
	dev-lisp/sbcl:=
	dev-lang/perl:*
	sci-mathematics/z3:*
"
RDEPEND="
	${DEPEND}
"

my_lisp() {
	# FIXME: We could support other Lisps. For instance, the GNUmakefile
	#        by default uses Clozure CL.
	echo "/usr/bin/sbcl --noinform --noprint --no-sysinit --no-userinit --disable-debugger"
}

src_compile() {
	# Build ACL2.
	emake -f GNUmakefile LISP="$(my_lisp)" ACL2_COMPILER_DISABLED=t

	if ! use books-none; then
		local which_books
		use books-basic && which_books=basic
		use books-all && which_books=all
		use books-everything && which_books=everything

		# Build the books (except the very slow ones, etc.).
		emake -f GNUmakefile LISP="$(my_lisp)" ACL2=`pwd`/saved_acl2 USE_QUICKLISP=1 ACL2_COMPILER_DISABLED=t clean-books
		emake -C books -f GNUmakefile LISP="$(my_lisp)" ACL2=`pwd`/saved_acl2 USE_QUICKLISP=1 ACL2_COMPILER_DISABLED=t ${which_books}

		#       ***** Building the manual seems not to work,
		#       ***** after an upgrade of sbcl or some such change.
		# Build the manual.
		#emake -C books -f GNUmakefile LISP="$(my_lisp)" ACL2=`pwd`/saved_acl2 USE_QUICKLISP=1 ACL2_COMPILER_DISABLED=t manual
	fi
}

src_install() {
	# Change the path to the dumped core.
	sed -i -e "s:${S}:/usr/share/acl2:g" saved_acl2 || die

	# Tell ACL2 where to find the books.
	sed -i -e "/^# Saved/a\\
\\
export ACL2_SYSTEM_BOOKS=/usr/share/acl2/books/" \
		saved_acl2 || die

	# Install the script, but under the name ‘acl2’.
	cp saved_acl2 ${PN} || die
	dobin ${PN}

	insinto /usr/share/acl2
	doins TAGS saved_acl2.core

	if ! use books-none; then
		# The books must have their write times preserved, or the
		# certificates will be bad. Therefore use ‘cp -a’ instead of
		# ‘doins -r’.
		cp -a books "${ED}"/usr/share/acl2 || die
	fi
}
