# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

CHICKEN_MAJOR_VERSION=5
CHICKEN_EGG_PN=${PN/srfi/srfi-}
CHICKEN_EGG_P=${CHICKEN_EGG_PN}-${PV}

HOMEPAGE="
	https://code.call-cc.org/
	http://wiki.call-cc.org/eggref/${CHICKEN_MAJOR_VERSION}/${CHICKEN_EGG_PN}
"
IUSE=""

SRC_URI="
	https://code.call-cc.org/egg-tarballs/${CHICKEN_MAJOR_VERSION}/${CHICKEN_EGG_PN}/${CHICKEN_EGG_P}.tar.gz
		-> chicken-${P}.tar.gz
"

S="${WORKDIR}/${CHICKEN_EGG_P}"

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_test \
				 src_install pkg_postinst pkg_postrm

chicken-egg_src_prepare() {
	default

	# FIXME: Is it really a good idea always to do this? Probably. :)
	# But, because the version is not required, when the egg is in the
	# main repository, calling the entry ‘missing’ probably is not
	# good.
	chicken-egg_add_missing_version_to_egg_file
}

chicken-egg_src_configure() {
	:
}

chicken-egg_src_compile() {
	chicken-install -v -n -no-install-dependencies || die
}

chicken-egg_src_test() {
	# FIXME: Come up with a way to run the tests.
	:
}

chicken-egg_src_install() {
	DESTDIR="${D}" chicken-install -v -no-install-dependencies || die
	einstalldocs
}

chicken-egg_pkg_postinst() {
	chicken-install -v -u || die
}

chicken-egg_pkg_postrm() {
	chicken-install -v -u || die
}

chicken-egg_egg_file__() {
	local egg_file
	if [ -n "${1}" ]; then
		egg_file="${1}"
	else
		egg_file="${PN/srfi/srfi-}.egg"
	fi
	[[ -e "${egg_file}" ]] || die "${egg_file} does not exist"
	[[ -f "${egg_file}" ]] || die "${egg_file} is not a regular file"
	[[ -r "${egg_file}" ]] || die "${egg_file} is not readable"
	echo -n "${egg_file}"
}

chicken-egg_version__() {
	local version
	if [ -n "${1}" ]; then
		version="${1}"
	else
		version="${PV}"
	fi
	echo -n "${version}"
}

chicken-egg_egg_file_contains_member() {
	local key="${1}"
	local egg_file="$(chicken-egg_egg_file__ "${2}")"
	chicken-csi -e '(with-input-from-file "'"${egg_file}"'" (lambda () (let* ((egg (read)) (pair (assq '"'${key}"' egg))) (exit (if pair 0 1)))))'
}

chicken-egg_egg_file_key_value_matches() {
	local key="${1}"
	local value="${2}"
	local egg_file="$(chicken-egg_egg_file__ "${3}")"
	chicken-csi -e '(with-input-from-file "'"${egg_file}"'" (lambda () (let* ((egg (read)) (pair (assq '"'${key}"' egg))) (exit (if (and (list? pair) (= 2 (length pair)) (string? (cadr pair)) (string=? (cadr pair) '"'${value}"')) 0 1)))))'
}

chicken-egg_egg_file_remove_member() {
	local key="${1}"
	local egg_file="$(chicken-egg_egg_file__ "${2}")"
	local tempfile="${T}/tmp.$$"
	chicken-csi -e '(with-input-from-file "'"${egg_file}"'" (lambda () (let ((egg (read))) (let loop ((lst (list)) (egg egg)) (if (null? egg) (write (reverse lst)) (let ((pair (car egg))) (if (and (list? pair) (= 2 (length pair)) (eq? (car pair) (quote '"${key}"'))) (loop lst (cdr egg)) (loop (cons pair lst) (cdr egg)))))))))' > "${tempfile}" || die
	mv "${tempfile}" "${egg_file}" || die
}

chicken-egg_cons_member_to_egg_file() {
	local key="${1}"
	local data="${2}"
	local egg_file="$(chicken-egg_egg_file__ "${3}")"
	local tempfile="${T}/tmp.$$"
	chicken-csi -e '(with-input-from-file "'"${egg_file}"'" (lambda () (let* ((egg (read)) (egg (cons '"'(${key} ${data})"' egg))) (write egg))))' > "${tempfile}" || die
	mv "${tempfile}" "${egg_file}" || die
}

chicken-egg_add_missing_version_to_egg_file() {
	local egg_file="$(chicken-egg_egg_file__ "${1}")"
	local version="$(chicken-egg_version__ "${2}")"
	if chicken-egg_egg_file_contains_member version "${egg_file}"; then
		if chicken-egg_egg_file_key_value_matches version "\"${version}\"" "${egg_file}"; then
			:
		else
			elog "Replacing incorrect version entry in ${egg_file} with '(version \"${version}\")"
			chicken-egg_egg_file_remove_member version "${egg_file}"
			chicken-egg_cons_member_to_egg_file version "\"${version}\"" "${egg_file}"
		fi
	else
		elog "Adding missing entry '(version \"${version}\") to ${egg_file}"
		chicken-egg_cons_member_to_egg_file version "\"${version}\"" "${egg_file}"
	fi
}
