# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Manage multiple Guile versions on one system"
HOMEPAGE="https://bitbucket.org/sortsmill/sortsmill-gentoo-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="
	>=app-admin/eselect-1.2.6:*
	sys-apps/coreutils:*
	sys-apps/findutils:*
	sys-apps/sed:*
	!<dev-scheme/guile-1.8.8-r3
	!=dev-scheme/guile-2.0.9999-r3
	!app-admin/eselect-guile
"

# We don't have any source directory to work on.
S="${T}"

src_install() {
	cat > "${T}/selections" <<EOF
# Possible guile selections, in order.

guile-1.8
guile-2.0
guile-2.2
EOF

	dodir "/etc/eselect-guile"
	insinto "/etc/eselect-guile"
	doins "${T}"/selections

	insinto /usr/share/eselect/modules
	doins "${FILESDIR}"/guile.eselect
	doman "${FILESDIR}"/guile.eselect.5
}

pkg_postinst() {
	ewarn "If you are upgrading from an older version of"
	ewarn " ${CATEGORY}/${PN}, you should do"
	ewarn "  eselect guile list"
	ewarn "to see if you need to re-select your system Guile."
	ewarn "You might have to rebuild dev-scheme/guile before"
	ewarn "re-selecting."
}

# app-admin/eselect-guile from the `lisp' overlay does the following,
# but an inadvertent result is that upgrading eselect-guile deletes
# one’s selection! So do not do it. If you need to clean up, you
# can temporarily install app-eselect/eselect-guile and manually
# run `eselect guile unset'.
#
#pkg_prerm() {
#	# Do not leave a mess.
#	eselect guile unset
#}
