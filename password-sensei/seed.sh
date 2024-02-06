NAME="password-sensei"
DESC="A password learning tool that asks for random account passwords and compares them to stored hashes"
VERSION="1.0.0"
SOURCE="http://birbgitfh224rep6tmdofmr6qlo6wx43umqzt3hjubnncr55sdlfmtad.onion/toasterbirb/password-sensei/archive/${VERSION}.tar.gz"
CHECKSUM="4a240b78ffa53fcad92a325ab57fe6be"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}
}

_build()
{
	printf ""
}

_install()
{
	make PREFIX=/usr DESTDIR=$FAKEROOT/$NAME install
}
