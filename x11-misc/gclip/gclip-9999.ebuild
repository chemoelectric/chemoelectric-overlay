# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="gClip clipboard manager"
HOMEPAGE="http://gclip.uhvo.org/"
SRC_URI="http://gclip.uhvo.org/sec/gclip.txt
	 http://www.openclipart.org/image/64px/svg_to_png/edit-paste.png"
LICENSE="not yet in Portage" # CCPL Attribution-NonCommercial-ShareAlike 1.0
	                     # Also CCPD for the icon from Open Clip Art.

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND="dev-lang/perl
	 >=dev-perl/gtk2-trayicon-0.06"

src_install() {
	newbin "${DISTDIR}/gclip.txt" gclip
	make_desktop_entry gclip \
	    gClip \
	    /usr/share/pixmaps/gclip.png \
	    "GTK;GNOME;Application;Utility;"
	
	insinto /usr/share/pixmaps
	newins "${DISTDIR}/edit-paste.png" gclip.png
}
