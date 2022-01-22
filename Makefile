# Created by: Samuel A. Winful <samuel@winful.com>

PORTNAME=	cardano-node
PKGNAMEPREFIX=
DISTVERSION=	1.33.0
CATEGORIES=	net-p2p finance haskell

MAINTAINER=     samuel@winful.com
COMMENT?=       Cardano node to validate transaction processing and block production

LICENSE=        APACHE20
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=  ghc:lang/ghc \
		cabal:devel/hs-cabal-install \
		libtool:devel/libtool \
		git:devel/git \
		gcc10:lang/gcc10 \
		pkgconf:devel/pkgconf

LIB_DEPENDS=    libgmp.so:math/gmp \
		libsodium.so:security/libsodium \
		libffi.so:devel/libffi \
		libncurses.so:devel/ncurses

USERS=		cardano
GROUPS=		cardano

# Personal Var
MAINNET_NETWORKMAGIC=764824073
TESTNET_NETWORKMAGIC=1097911063

# USES=           cabal:nodefault autoreconf compiler:c++11-lib gmake ncurses libtool pkgconfig ssl

USE_GITHUB=     yes
GH_ACCOUNT=     input-output-hk
GH_TAGNAME=     ${DISTVERSION}

PLIST_FILES=    bin/cardano-node bin/cardano-cli




do-configure:
	cd ${WRKSRC} && \
		${SETENV} LD_LIBRARY_PATH=/usr/local/lib \
		  PKG_CONFIG_PATH=/usr/local/libdata/pkgconfig \
		cabal update && \
		cabal configure --with-compiler=ghc-8.10.7 && \
		echo "package cardano-crypto-praos" >>  cabal.project.local && \
		echo "  flags: -external-libsodium-vrf" >>  cabal.project.local

do-build:
	cd ${WRKSRC} && \
		${SETENV} LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib \
		  PKG_CONFIG_PATH=/usr/local/libdata/pkgconfig \
		  cabal build cardano-node cardano-cli

do-install: 
# executables
# Is there a better way?
	echo "Post install"
.for cexec in cardano-cli cardano-node
	${INSTALL_PROGRAM} \
		${WRKSRC}/dist-newstyle/build/${MACHTYPE}-freebsd/ghc-8.10.7/${cexec}-${DISTVERSION}/x/${cexec}/build/${cexec}/${cexec} \
		${STAGEDIR}${PREFIX}/bin/
.endfor


.include <bsd.port.mk>
