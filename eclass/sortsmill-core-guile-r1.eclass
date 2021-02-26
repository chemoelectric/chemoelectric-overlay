# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Multilib build of Sortsmill Core Guile.
#
# Note that, at the time of this writing, Gentoo does not have
# multilib support for C-Python, and neither does the sortsmill
# overlay. Therefore Python is supported only for the default ABI.

SORTSMILL_REPO_TYPE=git
SORTSMILL_NEED_GNULIB=no

GUILE_COMPAT=( guile2_0 guile2_2 )

# FIXME: Builds against Python > 3.3 (or maybe it is > 3.4) have never
# been tried by us and may work incorrectly.
PYTHON_COMPAT=( python3_{7,8,9} )

inherit eutils
inherit toolchain-funcs
inherit multilib-build
inherit python-r1
inherit sortsmill

DESCRIPTION="Sorts Mill Core Guile"
[[ ${PV} == 9999* ]] && DESCRIPTION="${DESCRIPTION} (live ebuild)"

IUSE="nls python"
for target in ${GUILE_COMPAT[@]}; do
	IUSE+=" guile_targets_${target}"
	IUSE+=" guile_single_target_${target}"
done

LINGUA_REPERTOIRE_SRC=":eo :en-US"
LINGUA_REPERTOIRE="${LINGUA_REPERTOIRE_SRC//:/ }"
IUSE+=" ${LINGUA_REPERTOIRE_SRC//:/l10n_}"

REQUIRED_USE="
	|| ( ${GUILE_COMPAT[@]/guile/guile_targets_guile} )
	^^ ( ${GUILE_COMPAT[@]/guile/guile_single_target_guile} )
"
for target in ${GUILE_COMPAT[@]}; do
	REQUIRED_USE+="
		${target/guile/guile_single_target_guile}?
			( ${target/guile/guile_targets_guile} )
	"
done

LICENSE="GPL-3+"

COMMON_DEPENDS="
	>=dev-libs/sortsmill-core-1.0.0:*[${MULTILIB_USEDEP}]
	>=media-libs/libunicodenames-1.2.0:*[${MULTILIB_USEDEP}]
	python? ( ${PYTHON_DEPS} )
"
for target in ${GUILE_COMPAT[@]}; do
	gev_=${target/guile/}
	gev=${gev_/_/.}
	COMMON_DEPENDS+="
		guile_targets_guile${gev_}? (
			>=dev-scheme/guile-2.0.14:${gev}[${MULTILIB_USEDEP}]
		)
	"
done
RDEPEND+=" ${COMMON_DEPENDS}"
DEPEND+=" ${COMMON_DEPENDS}"

EXPORT_FUNCTIONS \
	src_prepare \
	src_configure \
	src_compile \
	src_install

ECONF_SOURCE="${S}"

_build_dir() {
	echo "${WORKDIR}/build.${1}"
}

_guile_targets() {
	local t
	for t in ${GUILE_COMPAT[@]}; do
		use guile_targets_${t} && echo ${t}
	done
}

_guile_single_target() {
	local t
	for t in ${GUILE_COMPAT[@]}; do
		use guile_single_target_${t} &&	echo ${t}
	done
}

_target_to_gev() {
	echo "${1/guile/}" | tr '_' '.'
}

sortsmill-core-guile-r1_src_prepare() {
	sortsmill_src_prepare
}

sortsmill-core-guile-r1_multilib_src_configure() {
	#
	# Configure outside-of-source builds.
	#

	use nls && strip-linguas ${LINGUA_REPERTOIRE}
	local enables=" $(use_enable nls)"

	local t
	for t in $(_guile_targets); do
		if ! multilib_is_native_abi || ! use python; then
			mkdir "$(_build_dir "${ABI}.${t}")" || die
			pushd "$(_build_dir "${ABI}.${t}")" >/dev/null || die			
			econf ${enables} \
				  GUILE=guile-$(_target_to_gev ${t}) \
				  --without-python \
				  --program-prefix="${CHOST}-" \
				  --program-suffix="-gev$(_target_to_gev ${t})"
			popd >/dev/null
		else
			configure_one() {
				mkdir "$(_build_dir "${ABI}.${EPYTHON}.${t}")" || die
				pushd "$(_build_dir "${ABI}.${EPYTHON}.${t}")" >/dev/null || die
				econf ${enables} \
					  GUILE=guile-$(_target_to_gev ${t}) \
					  PYTHON="${PYTHON}" \
					  --with-python \
					  --program-prefix="${CHOST}-" \
					  --program-suffix="-gev$(_target_to_gev ${t})"
				popd >/dev/null
			}
			python_foreach_impl configure_one
		fi
	done
}

sortsmill-core-guile-r1_multilib_src_compile() {
	local t
	for t in $(_guile_targets); do
		if ! multilib_is_native_abi || ! use python; then
			pushd "$(_build_dir "${ABI}.${t}")" >/dev/null || die
			emake
			popd >/dev/null
		else
			compile_one() {
				pushd "$(_build_dir "${ABI}.${EPYTHON}.${t}")" >/dev/null || die
				emake
				popd >/dev/null
			}
			python_foreach_impl compile_one
		fi
	done
}

sortsmill-core-guile-r1_multilib_src_install() {
	local t

	for t in $(_guile_targets); do
		if ! multilib_is_native_abi || ! use python; then
			pushd "$(_build_dir "${ABI}.${t}")" >/dev/null || die
			sortsmill_src_install
			popd >/dev/null
		else
			install_one() {
				pushd "$(_build_dir "${ABI}.${EPYTHON}.${t}")" >/dev/null || die
				sortsmill_src_install
				popd >/dev/null
			}
			python_foreach_impl install_one
		fi
	done

	if is_final_abi; then
		t="$(_guile_single_target)"
		gev="$(_target_to_gev ${t})"

		# For scripts, we need only one of each. Rename it
		# without ‘${CHOST}-’ prefix or ‘-gevx.x’ suffix. Delete
		# all the others.
		pushd "${ED}/usr/bin" >/dev/null || die
		for script in sortsmill-apii-to-guile sortsmill-guile-mkdep; do
			mv "${CHOST}-${script}-gev${gev}" "${script}" || die
			rm -f *-"${script}"-*
		done
		popd >/dev/null

		# Create links for preferred programs; the links have
		# the names of the programs without ‘${CHOST}-’ prefix
		# or ‘-gevx.x’ suffix.
		pushd "${ED}/usr/bin" >/dev/null || die
		for program in "${CHOST}"-*-gev"${gev}"; do
			local link=`printf '%s' "${program}" | \
			  			   sed -e "s&^${CHOST}-&&" \
						       -e "s&-gev${gev}\$&&"`
			ln -s "${program}" "${link}" || die
		done
		popd >/dev/null
	fi
}

sortsmill-core-guile-r1_src_configure() {
	multilib_foreach_abi sortsmill-core-guile-r1_multilib_src_configure
}

sortsmill-core-guile-r1_src_compile() {
	multilib_foreach_abi sortsmill-core-guile-r1_multilib_src_compile
}

sortsmill-core-guile-r1_src_test() {
	multilib_foreach_abi sortsmill-core-guile-r1_multilib_src_test
}

sortsmill-core-guile-r1_src_install() {
	multilib_foreach_abi sortsmill-core-guile-r1_multilib_src_install
	dodoc AUTHORS ChangeLog NEWS README
}
