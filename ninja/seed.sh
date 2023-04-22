NAME="ninja"
DESC="Small build system with a focus on speed"
VERSION="1.11.1"
SOURCE="https://github.com/ninja-build/ninja/archive/v${VERSION}/ninja-${VERSION}.tar.gz"
CHECKSUM="32151c08211d7ca3c1d832064f6939b0"
DEPS="python3"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	python3 configure.py --bootstrap
}

_install()
{
	install -vm755 ninja $FAKEROOT/$NAME/usr/bin/
	install -vDm644 misc/bash-completion $FAKEROOT/$NAME/usr/share/bash-completion/completions/ninja
	install -vDm644 misc/zsh-completion  $FAKEROOT/$NAME/usr/share/zsh/site-functions/_ninja
}

_test()
{
	./ninja ninja_test
	./ninja_test --gtest_filter=-SubprocessTest.SetWithLots
}
