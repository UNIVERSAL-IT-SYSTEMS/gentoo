# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 python3_4 python3_5 )

inherit distutils-r1 versionator

MY_PV=$(replace_version_separator 2 '.fb' ${PV})

DESCRIPTION="A Python object API for managing the Linux LIO kernel target"
HOMEPAGE="https://github.com/open-iscsi/rtslib-fb"
SRC_URI="https://github.com/open-iscsi/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	!dev-python/rtslib"
RDEPEND="dev-python/pyudev[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	!dev-python/rtslib"

S=${WORKDIR}/${PN}-${MY_PV}

src_install() {
	distutils-r1_src_install

	doman "doc/saveconfig.json.5" "doc/targetctl.8"
}
