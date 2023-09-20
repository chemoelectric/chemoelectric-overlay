# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 )
DISTUTILS_USE_PEP517=flit

inherit pypi
inherit distutils-r1

DESCRIPTION="Visual Simulation of a Two-Channel Quantum Bell Test Experiment"
HOMEPAGE="https://pypi.org/project/Quantum-Correlations-Visualized/"

LICENSE="Unlicense"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pyglet-2.0.9"
DEPEND="
	${RDEPEND}
	dev-python/flit-core[${PYTHON_USEDEP}]
"
