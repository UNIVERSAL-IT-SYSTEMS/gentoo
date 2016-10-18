# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

GITHUB_REV="48124f838b00ff83a044fbf046a9d8d0b1602d90"
MY_PN="${PN}-${GITHUB_REV}"

DESCRIPTION="System performance benchmark"
HOMEPAGE="https://github.com/akopytov/sysbench"

SRC_URI="https://github.com/akopytov/sysbench/archive/${GITHUB_REV}.zip -> ${MY_PN}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="aio mysql"

DEPEND="aio? ( dev-libs/libaio )
	mysql? ( virtual/libmysqlclient )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	default

	sed -i -e "/^htmldir =/s:=.*:=/usr/share/doc/${PF}/html:" doc/Makefile.am || die

	./autogen.sh || die
}

src_configure() {
	local myeconfargs=(
		$(use_enable aio aio)
		$(use_with mysql mysql)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default

	insinto /usr/share/${PN}/tests/db
	doins sysbench/tests/db/*.lua || die
}
