# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker multiprocessing toolchain-funcs pax-utils

DESCRIPTION="The GNU Omnificent GUI for Ada"
HOMEPAGE="http://www.gnoga.com/"
SRC_URI="
	http://www.gnoga.com/${P}.zip
	doc? ( https://bitbucket.org/chemoelectric/chemoelectric-overlay/downloads/MultiMarkdown-4.20170506.tar.xz )
"

LICENSE="
	GPL-3 gcc-runtime-library-exception-3.1 FDL-1.3
	doc? ( MIT GPL-2+ )
"
SLOT="0"
KEYWORDS="~amd64"

# FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME
IUSE="doc examples secure tools"
# FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME

RDEPEND="
	virtual/ada:*
	dev-ada/components:*
	dev-ada/components-connections_server:*
	dev-ada/components-connections_server-http_server:*
	x11-libs/gtk+:3
	net-libs/webkit-gtk:3
"
DEPEND="
	${RDEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900
"

S="${WORKDIR}/${PN}-${PV/[a-z]/}"

# FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME
PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )
# FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME

XXXXXXQA_EXECSTACK="
	usr/bin/gnoga_make
	usr/bin/gnoga_doc
	usr/*/gnoga/gnoga.static/libgnoga.a:gnoga-server-template_parser.o
	usr/*/gnoga/gnoga.static/libgnoga.a:gnoga-server-model.o
	usr/*/gnoga/gnoga.static/libgnoga.a:gnoga-server-migration.o
	usr/*/gnoga/gnoga.static/libgnoga.a:gnoga-server-connection.o
	usr/*/gnoga/gnoga.static/libgnoga.a:gnoga-gui-view.o
	usr/*/gnoga/gnoga.static/libgnoga.a:gnoga-gui-plugin-message_boxes.o
"

MY_GPRBUILD="${GPRBUILD:-gprbuild}"
MY_GPRINSTALL="${GPRINSTALL:-gprinstall}"

prj_target() {
	local target="$(tc-getCC) -dumpmachine"
	if echo "${target}" | grep -q -F linux ; then
		echo Linux
	elif echo "${target}" | grep -q -F freebsd ; then
		echo Freebsd
	elif echo "${target}" | grep -q -F darwin ; then
		echo OSX
	elif echo "${target}" | grep -q -F mingw32 ; then
		echo Windows
	elif echo "${target}" | grep -q -F cygwin ; then
		echo Windows
	else
		echo Unix
	fi
}

src_prepare() {
	default

	case "$(prj_target)" in
		Windows)
			cp src/gnoga-application.windows src/gnoga-application.adb || die
			;;
		OSX)
			cp src/gnoga-application.osx src/gnoga-application.adb || die
			;;
		*)
			cp src/gnoga-application.linux src/gnoga-application.adb || die
	esac

	
}

# FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME
my_emake() {
	emake BUILDER="${MY_GPRBUILD} -R -v -j$(makeopts_jobs)" \
		  INSTALLER="${MY_GPRINSTALL} -v" \
		  PREFIX="${D}/usr" LIBDIR="$(get_libdir)" \
		  ${1+"$@"}
}
# FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME

src_configure() {
	:
}

#src_compile() {
#	export BUILD_TYPE=static
#	my_emake release
#	use secure && my_emake gnoga_secure
#	use tools && my_emake gnoga_tools
#
#	use doc && {
#		# Prevent the C compiler from issuing warnings, so we do not
#		# get QA notices about bugs in MultiMarkdown-4. Also we need
#		# neither optimization nor debugging symbols, because we are
#		# throwing away the compiled program.
#		emake -C "${WORKDIR}"/MultiMarkdown-4 CFLAGS="2>/dev/null"
#		mv "${WORKDIR}"/MultiMarkdown-4/multimarkdown bin/. || die
#		my_emake html-docs
#	}
#}

prepare_examples() {
	# Modify the examples so they are not dependent on the original
	# build environment.
	cp -R settings.gpr css html img js "${D}${1}" || die
	sed -i \
		-e 's|("PRJ_TARGET", "Unix")|("PRJ_TARGET", "'"${prj_target}"'")|' \
		"${D}${1}"/settings.gpr
	mkdir "${D}${1}"/{obj,bin} || die
	touch "${D}${1}"/{obj,bin}/.keep || die
	for f in $(find "${D}${1}" -name '*.gpr'); do
		sed -i \
			-e 's|../../settings.gpr|../settings.gpr|' \
			-e 's|../../src/gnoga.gpr|gnoga|' \
			-e 's|../../obj|../obj|' \
			-e 's|../../bin|../bin|' \
			"${f}"
	done
}

FIXME_src_install() {
	export BUILD_TYPE=static
	my_emake install
	use secure && my_emake install_gnoga_secure
	use tools && my_emake install_gnoga_tools
	pax-mark m "${D}"/usr/bin/gnoga_{make,doc}

	einstalldocs
	dodoc deps/simple_components/components.htm
	use doc && dodoc -r docs

	use examples && {
		local prj_target=$(my_emake prj_target)
		local demodir="/usr/share/doc/${PF}/examples/demo/"
		local tutdir="/usr/share/doc/${PF}/examples/tutorial/"

		docinto examples
		dodoc -r test test_ssl tutorial

		prepare_examples "${tutdir}" || die
		cat > "${D}${tutdir}"/../README.tutorial <<-EOF
			To build and run the tutorials, copy the \`tutorial'
			subdirectory somewhere and follow the instructions
			in tutorial/README. You will need sqlite3 for
			tutorials 10 and 11.
		EOF

		docinto examples/demo
		pushd demo || die
		for d in *; do
			dodoc -r "${d}"
			mv "${D}${demodir}/${d}" "${D}${demodir}/demo_${d}" || die
		done
		popd || die
		dodoc -r src
		prepare_examples "${demodir}" || die
		cat > "${D}${demodir}"/Makefile <<EOF
.NOTPARALLEL:
.PHONY: all
GPRBUILD = gprbuild -j0
GIT = git
all: snake mine_detector chattanooga adaedit adablog connect_four
snake:
	cd demo_snake && \$(GPRBUILD) -Psnake.gpr
mine_detector:
	cd demo_mine_detector && \$(GPRBUILD) -Pmine_detector.gpr
chattanooga:
	cd demo_chattanooga && \$(GPRBUILD) -Pchattanooga.gpr
adaedit: js/ace_editor
	cd demo_adaedit && \$(GPRBUILD) -Padaedit.gpr
js/ace_editor:
	cd js && \$(GIT) clone https://github.com/ajaxorg/ace-builds.git
adablog:
	cd demo_adablog && \$(GPRBUILD) -Padablog.gpr
connect_four:
	cd demo_connect_four && \$(GPRBUILD) -Pconnect_four.gpr
EOF
		cat > "${D}${demodir}"/../README.demo <<-EOF
			To build and run the demos, you should have gprbuild
			git, and sqlite3 installed. First copy the \`demo' subdirectory
			somewhere, go into the copied directory, and run make.
			The Makefile will install the demo programs in \`demo/bin'
			and use git to download some necessary JavaScript.
		EOF
	}
}
