# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit unpacker cmake-multilib

MY_P="deviceatlas-enterprise-c-${PV}"

DESCRIPTION="API to detect devices based on the User-Agent HTTP header"
HOMEPAGE="https://deviceatlas.com"
SRC_URI="https://deviceatlas.com/download/api/enterprise/c -> ${MY_P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="doc examples"

RESTRICT="fetch"

CDEPEND="dev-libs/libpcre[${MULTILIB_USEDEP}]"
DEPEND="app-arch/unzip
	${CDEPEND}"
RDEPEND="${CDEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_nofetch() {
	eerror "Please go to https://deviceatlas.com/deviceatlas-haproxy-module"
	eerror "And download DeviceAtlas C API"
	eerror "Then place the file in ${DISTDIR}/${MY_P}.zip"
}

multilib_src_install() {
	dolib libda.so libda.so.${PV}
}

multilib_src_install_all() {
	doheader dac.h dac_json.h

	if use doc ; then
		HTML_DOCS=( Documentation )
	fi

	if use examples ; then
		insinto /usr/share/doc/${P}
		doins examples/daexutil.h
		doins examples/example{0,1,2,3}.c
		doins examples/util.c
		DOC+=( examples/EXAMPLES.USAGE )
	fi

	einstalldocs
}
