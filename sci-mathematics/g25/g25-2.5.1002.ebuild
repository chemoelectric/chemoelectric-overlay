# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit g25

SLOT="0"
KEYWORDS="~amd64"

# There is still some undesired randomness somewhere in the regression
# tests, causing an occasional failure. Perhaps something to do with
# evaluation order of genrand() calls.
RESTRICT=test
