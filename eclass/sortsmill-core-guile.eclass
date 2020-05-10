# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

SORTSMILL_REPO_TYPE=git
SORTSMILL_NEED_GNULIB=no

PYTHON_COMPAT=( python2_7 )

inherit eutils autotools python-r1 sortsmill

DESCRIPTION="Sorts Mill Core Guile"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"

IUSE="nls python"

LINGUA_REPERTOIRE_SRC=":eo :en-US"
LINGUA_REPERTOIRE="${LINGUA_REPERTOIRE_SRC//:/ }"
IUSE+=" ${LINGUA_REPERTOIRE_SRC//:/l10n_}"

LICENSE="GPL-3+"

_SORTSMILL_CORE_COMMON_DEPENDS="
	>=dev-libs/sortsmill-core-1.0.0
	>=media-libs/libunicodenames-1.2.0
	>=dev-scheme/guile-2.0.9-r1
	python? ( ${PYTHON_DEPS} )
"
RDEPEND+=" ${SORTSMILL_CORE_COMMON_DEPENDS}"
DEPEND+=" ${SORTSMILL_CORE_COMMON_DEPENDS}"
unset _SORTSMILL_CORE_COMMON_DEPENDS

# FIXME: The pkg_postinst may be desired once there are tests.
#EXPORT_FUNCTIONS src_configure pkg_postinst
EXPORT_FUNCTIONS src_prepare src_configure src_compile src_install

sortsmill-core-guile_src_prepare() {
	sortsmill_src_prepare
	use python && python_copy_sources
}

sortsmill-core-guile_src_configure() {
	use nls && strip-linguas ${LINGUA_REPERTOIRE}
	local enables=" $(use_enable nls)"
	
	if ! use python; then
		econf --docdir="/usr/share/doc/${PF}" ${enables}
	else
		configure_one() {
			cd ${BUILD_DIR}

			# FIXME: The following is inadequate if the Python library
			# has ABI letters in its name. For example: `libpython3.3m.so'
			econf --docdir="/usr/share/doc/${PF}" ${enables} \
				--with-python=`${PYTHON} -c 'import sys; print (str(sys.version_info[0]) + "." + str(sys.version_info[1]))'`
		}
		python_foreach_impl configure_one
	fi
}

sortsmill-core-guile_src_compile() {
	if ! use python; then
		default
	else
		compile_one() {
			cd ${BUILD_DIR}
			default
		}
		python_foreach_impl compile_one
	fi
}

sortsmill-core-guile_src_install() {
	if ! use python; then
		sortsmill_src_install
	else
		install_one() {
			cd ${BUILD_DIR}
			sortsmill_src_install
		}
		python_foreach_impl install_one
	fi
}

# FIXME: This pkg_postinst may be desired once there are tests.
#sortsmill-core-guile_pkg_postinst() {
#	ewarn "If you get a message like the following, you should just ignore it:"
#	ewarn ""
#	ewarn "   QA Notice: Automake \"maintainer mode\" detected:"
#	ewarn ""
#	ewarn "     /bin/sh ../config/missing --run autom4te --language=autotest -I '.' -o testsuite.tmp testsuite.at"
#	ewarn ""
#	ewarn "This particular recipe actually has nothing to do with \"maintainer mode\"."
#}
