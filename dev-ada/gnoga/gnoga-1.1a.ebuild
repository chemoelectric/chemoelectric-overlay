# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# FIXME: This ebuild builds only static libraries, which is all
# upstream supports. We nevertheless might want to support static-pic
# and relocatable libraries (or even submit patches to upstream).

inherit unpacker multiprocessing

DESCRIPTION="The GNU Omnificent GUI for Ada"
HOMEPAGE="http://www.gnoga.com/"
SRC_URI="
	http://www.gnoga.com/${P}.zip
	doc? ( https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/MultiMarkdown-4.20170506.tar.xz )
"

LICENSE="GPL-3 gcc-runtime-library-exception-3.1 FDL-1.3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

# FIXME: Add the demos as another option.
IUSE="doc tutorial secure tools"

# FIXME: Include all the dependencies.
RDEPEND="virtual/ada:*"
DEPEND="
	${RDEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900
"

S="${WORKDIR}/${PN}-${PV/[a-z]/}"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )

QA_EXECSTACK="
	usr/*/gnoga/static/libgnoga.a:gnoga-server-template_parser.o
	usr/*/gnoga/static/libgnoga.a:gnoga-server-model.o
	usr/*/gnoga/static/libgnoga.a:gnoga-server-migration.o
	usr/*/gnoga/static/libgnoga.a:gnoga-server-connection.o
	usr/*/gnoga/static/libgnoga.a:gnoga-gui-view.o
	usr/*/gnoga/static/libgnoga.a:gnoga-gui-plugin-message_boxes.o
	usr/*/gnoga/static/persistent-memory_pools-streams.o
	usr/bin/gnoga_make
	usr/bin/gnoga_doc
"

MY_GPRBUILD="${GPRBUILD:-gprbuild}"
MY_GPRINSTALL="${GPRINSTALL:-gprinstall}"

my_emake() {
	emake BUILDER="${MY_GPRBUILD} -R -v -j$(makeopts_jobs)" \
		  INSTALLER="${MY_GPRINSTALL} -v" \
		  PREFIX="${D}/usr" LIBDIR="$(get_libdir)" \
		  ${1+"$@"}
}

src_configure() {
	:
}

src_compile() {
	export BUILD_TYPE=static
	my_emake release
	use secure && my_emake gnoga_secure
	use tools && my_emake gnoga_tools

	use doc && {
		# Prevent the C compiler from issuing warnings, so we do not
		# get QA notices about bugs in MultiMarkdown-4. Also we need
		# neither optimization nor debugging symbols, because we are
		# throwing away the compiled program.
		emake -C "${WORKDIR}"/MultiMarkdown-4 CFLAGS="2>/dev/null"
		mv "${WORKDIR}"/MultiMarkdown-4/multimarkdown bin/. || die
		my_emake html-docs
	}
}

src_install() {
	export BUILD_TYPE=static
	my_emake install
	use secure && my_emake install_gnoga_secure
	use tools && my_emake install_gnoga_tools

	einstalldocs
	use doc && dodoc -r docs

	use tutorial && {
		dodoc -r tutorial
		sed -i \
			-e '/Once the executable has been built it will be in the gnoga\/bin directory./d' \
			"${D}/usr/share/doc/${PF}/tutorial/README"
		cp settings.gpr "${D}/usr/share/doc/${PF}/tutorial" || die
		for f in $(find "${D}/usr/share/doc/${PF}/tutorial" -name '*.gpr'); do
			sed -i \
				-e 's|../../settings.gpr|../settings.gpr|' \
				-e 's|../../src/gnoga.gpr|gnoga|' \
				-e 's|../../obj|obj|' \
				-e 's|../../bin|.|' \
				"${f}"
		done
	}
}
