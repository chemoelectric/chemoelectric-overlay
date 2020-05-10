# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

SORTSMILL_REPO_TYPE=git
SORTSMILL_NEED_GNULIB=no

PYTHON_COMPAT=( python2_7 python3_6 )

inherit python-r1
inherit sortsmill

DESCRIPTION="Sorts Mill PsMat"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"
LICENSE="GPL-3+"

IUSE="install-as-psMat"

COMMON_DEPEND=""
for p in ${PYTHON_COMPAT[@]}; do
	COMMON_DEPEND+="
		python_targets_${p}? (
			install-as-psMat? (
				!media-gfx/fontforge[python,python_targets_${p}]
				!media-gfx/fontforge[python,python_single_target_${p}]
			)
		)
	"
done
RDEPEND="
	${COMMON_DEPEND}
	python_targets_python2_7? (
		dev-python/sortsmill-python-package[python_targets_python2_7]
	)
"
DEPEND="
	${COMMON_DEPEND}
	dev-python/cython
"

EXPORT_FUNCTIONS \
	src_prepare \
	src_configure \
	src_compile \
	src_test \
	src_install

QA_AM_MAINTAINER_MODE=".*--language=autotest.*"

ECONF_SOURCE="${S}"

_build_dir() {
	echo "${WORKDIR}/build.${1}"
}

sortsmill-psmat_src_prepare() {
	sortsmill_src_prepare

	# In case psMat.pyx was patched, use Cython to recreate psMat.c.
	rm psMat.c || die
}

sortsmill-psmat_src_configure() {
	#
	# Configure outside-of-source builds.
	#
	configure_one() {
		mkdir "$(_build_dir "${EPYTHON}")" || die
		pushd "$(_build_dir "${EPYTHON}")" >/dev/null || die
		econf $(use_enable install-as-psMat)
		popd >/dev/null
	}
	python_foreach_impl configure_one
}

sortsmill-psmat_src_compile() {
	compile_one() {
		pushd "$(_build_dir "${EPYTHON}")" >/dev/null || die
		emake
		popd >/dev/null
	}
	python_foreach_impl compile_one
}

sortsmill-psmat_src_test() {
	test_one() {
		pushd "$(_build_dir "${EPYTHON}")" >/dev/null || die
		emake check
		popd >/dev/null
	}
	python_foreach_impl test_one
}

sortsmill-psmat_src_install() {
	install_one() {
		pushd "$(_build_dir "${EPYTHON}")" >/dev/null || die
		sortsmill_src_install
		popd >/dev/null
	}
	python_foreach_impl install_one

	# Okay, I will admit that we have little use for libtool archives
	# of Python extensions managed by Portage.
	find "${ED}" -name psMat.la -exec rm '{}' \;

	einstalldocs
}
