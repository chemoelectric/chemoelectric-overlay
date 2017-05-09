# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DEPENDS_ON_LIBRARIES=(
	"=dev-ada/components-${PV}*:=[single-tasking?,tracing?]"
)

SUB_DESCRIPTION="GnuTLS interface"

inherit simple-components-for-ada toolchain-funcs

COMMON_DEPEND="net-libs/gnutls:*"
DEPEND+=" ${COMMON_DEPEND} virtual/pkgconfig:*"
RDEPEND+=" ${COMMON_DEPEND}"

SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	# The following is used to link the relocatable components-gnutls
	# with libgnutls.so.
	cat > gnutls.gpr <<-EOF
		library project GNUTLS is
		   for Languages use ("C");
		   for Library_Dir use "$($(tc-getPKG_CONFIG) --variable libdir gnutls)";
		   for Library_Name use "gnutls";
		   for Library_Kind use "relocatable";
		   for Externally_Built use "True";
		end GNUTLS;
	EOF
}

src_install() {
	simple-components-for-ada_src_install

	# Remove `with "gnutls";' lines from the generated project file.
	sed -i -e '/with "gnutls";/d' "${D}/usr/share/gpr/${PN}.gpr" || die
}
