# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
ATS2_IMPLEMENTATION="${PV}"

inherit ats2

SLOT="${ATS2_IMPLEMENTATION}"
KEYWORDS="~amd64 ~x86"

# Work around an upstream problem that might be temporary.
src_install() {
	ats2_src_install
	if [[ -d "${ED}"/usr/ats2/ats2-0.3.12/lib/ats2-postiats-0.3.11 ]]; then
		if [[ -d "${ED}"/usr/ats2/ats2-0.3.12/lib/ats2-postiats-0.3.12 ]]; then
			mv "${ED}"/usr/ats2/ats2-0.3.12/lib/ats2-postiats-0.3.12 \
			   "${T}" || die
		fi
		mv "${ED}"/usr/ats2/ats2-0.3.12/lib/ats2-postiats-0.3.11 \
		   "${ED}"/usr/ats2/ats2-0.3.12/lib/ats2-postiats-0.3.12 || die
	fi
}
