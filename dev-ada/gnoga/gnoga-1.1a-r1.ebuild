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

IUSE="doc examples secure +tools"

RDEPEND="
	virtual/ada:*
	dev-ada/components:*
	dev-ada/components-connections_server:*
	dev-ada/components-connections_server-http_server:*
	dev-ada/xpm_parser:*
	x11-libs/gtk+:3
	net-libs/webkit-gtk:3
	dev-db/sqlite:3
	virtual/mysql:*
"
DEPEND="
	${RDEPEND}
	>=dev-ada/gprbuild-2016_p20170427191900
"

S="${WORKDIR}/${PN}-${PV/[a-z]/}"

PATCHES=( "${FILESDIR}/${PF}-gentoo.patch" )

QA_EXECSTACK="
	usr/*/gnoga/gnoga.static*/gnoga/libgnoga.a:gnoga-server-template_parser.o
	usr/*/gnoga/gnoga.static*/gnoga/libgnoga.a:gnoga-server-model.o
	usr/*/gnoga/gnoga.static*/gnoga/libgnoga.a:gnoga-server-migration.o
	usr/*/gnoga/gnoga.static*/gnoga/libgnoga.a:gnoga-server-connection.o
	usr/*/gnoga/gnoga.static*/gnoga/libgnoga.a:gnoga-gui-view.o
	usr/*/gnoga/gnoga.static*/gnoga/libgnoga.a:gnoga-gui-plugin-message_boxes.o
	usr/*/gnoga/gnoga.relocatable/gnoga/libgnoga.so*
	usr/bin/gnoga_make
"

GPRBUILD="${GPRBUILD:-gprbuild}"
GPRINSTALL="${GPRINSTALL:-gprinstall}"

library_types() {
	echo static static-pic relocatable
}

tool_linkage() {
	echo relocatable
}

tracing() {
#	echo ".tracing"
	echo ""
}

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

tc-getMYSQL_CONFIG() {
	tc-getPROG MYSQL_CONFIG mysql_config "$@"
}

src_prepare() {
	# Do not let the deps directory interfere with our build.
	rm -R deps || die

	sed -i -e 's/kebyoard/keyboard/' demo/snake/snake-connection.adb || die
	default
}

src_configure() {
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

	cat > sqlite3.gpr <<-EOF
		library project SQLite3 is
		   for Source_Files use ();
		   for Library_Dir use "$($(tc-getPKG_CONFIG) --variable libdir sqlite3)";
		   for Library_Name use "sqlite3";
		   for Library_Kind use "relocatable";
		   for Externally_Built use "True";
		end SQLite3;
	EOF

	cat > python.gpr <<-EOF
		library project Python is
		   for Source_Files use ();
		   for Library_Dir use "$($(tc-getPKG_CONFIG) --variable libdir python-2.7)";
		   for Library_Name use "python2.7";
		   for Library_Kind use "relocatable";
		   for Externally_Built use "True";
		end Python;
	EOF

	cat > gtk.gpr <<-EOF
		library project Gtk is
		   for Source_Files use ();
		   for Library_Dir use "$($(tc-getPKG_CONFIG) --variable libdir gtk+-3.0)";
		   for Library_Name use "gtk-3";
		   for Library_Kind use "relocatable";
		   for Externally_Built use "True";
		end Gtk;
	EOF

	cat > webkitgtk.gpr <<-EOF
		library project WebkitGtk is
		   for Source_Files use ();
		   for Library_Dir use "$($(tc-getPKG_CONFIG) --variable libdir webkitgtk-3.0)";
		   for Library_Name use "webkitgtk-3.0";
		   for Library_Kind use "relocatable";
		   for Externally_Built use "True";
		end WebkitGtk;
	EOF

	cat > mysqlclient.gpr <<-EOF
		library project MySQLclient is
		   for Source_Files use ();
		   for Library_Dir use "$($(tc-getMYSQL_CONFIG) --variable=pkglibdir)";
		   for Library_Name use "mysqlclient";
		   for Library_Kind use "relocatable";
		   for Externally_Built use "True";
		end MySQLclient;
	EOF
}

src_compile() {
	for lt in $(library_types); do
		export Gnoga_Version="${PV}"
		export PRJ_BUILD=Release
		export PRJ_TARGET="$(prj_target)"
		export Library_Type="${lt}"
		export STRINGS_EDIT_BUILD="${lt}"
		export TABLES_BUILD="${lt}"
		export COMPONENTS_BUILD="${lt}""$(tracing)"

		pushd src || die
		test -f gnoga.gpr || die
		CFLAGS="${CFLAGS} $($(tc-getPKG_CONFIG) --cflags gtk+-3.0)"
		CFLAGS="${CFLAGS} $($(tc-getPKG_CONFIG) --cflags webkitgtk-3.0)"
		${GPRBUILD} -j"$(makeopts_jobs)" -v -R -p -Pgnoga || die
		popd || die

		if use secure ; then
			pushd ssl || die
			test -f gnoga_secure.gpr || die
			${GPRBUILD} -j"$(makeopts_jobs)" -v -R -p -Pgnoga_secure || die
			popd || die
		fi

		if use tools && [[ "${lt}" == "$(tool_linkage)" ]] ; then
			pushd tools || die
			test -f tools.gpr || die
			${GPRBUILD} -j"$(makeopts_jobs)" -v -R -p -Ptools || die
			popd || die
		fi
	done

	use doc && {
		# Prevent the C compiler from issuing warnings, so we do not
		# get QA notices about bugs in MultiMarkdown-4. Also we need
		# neither optimization nor debugging symbols, because we are
		# throwing away the compiled program.
		emake -C "${WORKDIR}"/MultiMarkdown-4 CFLAGS="2>/dev/null"
		mv "${WORKDIR}"/MultiMarkdown-4/multimarkdown bin/. || die
		emake html-docs
	}
}

prepare_examples() {
	# Modify the examples so they are not dependent on the original
	# build environment.
	cp -R settings.gpr css html img js "${D}${1}" || die
	sed -i \
		-e 's|("PRJ_TARGET", "Unix")|("PRJ_TARGET", "'"$(prj_target)"'")|' \
		"${D}${1}"/settings.gpr
	mkdir "${D}${1}"/{obj,bin} || die
	touch "${D}${1}"/{obj,bin}/.keep || die
	for f in $(find "${D}${1}" -name '*.gpr'); do
		sed -i \
			-e 's|../../settings.gpr|../settings.gpr|' \
			-e 's|../../src/gnoga.gpr|gnoga|' \
			-e 's|../../obj|../obj|' \
			-e 's|../../bin|../bin|' \
			"${f}" || die
	done
}

src_install() {
	for lt in $(library_types); do
		export Gnoga_Version="${PV}"
		export PRJ_BUILD=Release
		export PRJ_TARGET="$(prj_target)"
		export Library_Type="${lt}"
		export STRINGS_EDIT_BUILD="${lt}"
		export TABLES_BUILD="${lt}"
		export COMPONENTS_BUILD="${lt}$(tracing)"

		pushd src || die
		${GPRINSTALL} -v -p -Pgnoga \
					  --prefix="${D}"/usr \
					  --install-name="${PN}" \
					  --build-name="${lt}" \
					  --lib-subdir="$(get_libdir)/${PN}/${PN}.${lt}" \
					  --link-lib-subdir="$(get_libdir)" \
					  --sources-subdir="include/${PN}/${PN}.${lt}" || die
		popd || die

		if use secure ; then
			pushd ssl || die
			${GPRINSTALL} -v -p -Pgnoga_secure \
						  --prefix="${D}"/usr \
						  --install-name="${PN}_secure" \
						  --build-name="${lt}" \
						  --lib-subdir="$(get_libdir)/${PN}/${PN}.${lt}" \
						  --link-lib-subdir="$(get_libdir)" \
						  --sources-subdir="include/${PN}/${PN}.${lt}" || die
			popd || die
		fi

		if use tools && [[ "${lt}" == "$(tool_linkage)" ]] ; then
			pushd tools || die
			${GPRINSTALL} -v -p -Ptools --prefix="${D}"/usr || die
			popd || die
			pax-mark m "${D}"/usr/bin/gnoga_{make,doc}
		fi
	done

	einstalldocs

	use doc && dodoc -r docs

	use examples && {
		local demodir="/usr/share/doc/${PF}/examples/demo/"
		local tutdir="/usr/share/doc/${PF}/examples/tutorial/"

		docinto examples
		dodoc -r test test_ssl tutorial

		prepare_examples "${tutdir}" || die
		cat > "${D}${tutdir}"/../README.tutorial <<-EOF
			To build and run the tutorials, copy the \`tutorial'
			subdirectory somewhere and follow the instructions
			in tutorial/README.
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
GPRBUILD = gprbuild -j0 -X{COMPONENTS,TABLES,STRINGS_EDIT}_BUILD=relocatable
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
			To build and run the demos, first copy the \`demo' subdirectory
			somewhere, go into the copied directory, and run make.
			The Makefile will install the demo programs in \`demo/bin'
			and use git to download some necessary JavaScript.
		EOF
	}
}
