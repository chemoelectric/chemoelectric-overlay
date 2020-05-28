# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="A user for the Web Service Discovery host daemon"

KEYWORDS="~amd64 ~arm ~x86"
ACCT_USER_GROUPS=( "wsdd" )
ACCT_USER_ID="-1"

acct-user_add_deps
