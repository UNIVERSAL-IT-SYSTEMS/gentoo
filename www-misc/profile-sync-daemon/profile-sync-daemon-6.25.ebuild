# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Symlinks and syncs browser profile dirs to RAM."
HOMEPAGE="https://wiki.archlinux.org/index.php/Profile-sync-daemon"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/graysky2/profile-sync-daemon"
	KEYWORDS=""
else
	SRC_URI="https://github.com/graysky2/profile-sync-daemon/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	RESTRICT="mirror"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	app-shells/bash
	net-misc/rsync[xattr]
	sys-apps/systemd"

src_install() {
	emake DESTDIR="${ED}" install
}
