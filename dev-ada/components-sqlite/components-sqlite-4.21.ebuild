# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SUB_DESCRIPTION="SQLite3 interface"

inherit toolchain-funcs simple-components-for-ada

COMMON_DEPEND="
	=dev-ada/components-${PV}*:=[single-tasking?,tracing?]
	dev-db/sqlite:3
"
DEPEND+="${COMMON_DEPEND} virtual/pkgconfig:*"
RDEPEND+="${COMMON_DEPEND}"

SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	# The following is used to link the relocatable components-sqlite3
	# with libsqlite3.so.
	cat > sqlite3.gpr <<-EOF
		library project SQLite3 is
		   for Source_Files use ();
		   for Library_Dir use "$($(tc-getPKG_CONFIG) --variable libdir sqlite3)";
		   for Library_Name use "sqlite3";
		   for Library_Kind use "relocatable";
		   for Externally_Built use "True";
		end SQLite3;
	EOF
}
