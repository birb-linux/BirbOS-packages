NAME="rustc"
DESC="Rust compiler"
VERSION="1.67.1"
SOURCE="https://static.rust-lang.org/dist/rustc-${VERSION}-src.tar.xz"
CHECKSUM="e5e47e53c52574ce89ea200e52819f81"
DEPS="cmake curl libssh2 llvm"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}-src
}

_build()
{
	# Install rustc to opt
	mkdir -pv $FAKEROOT/$NAME/opt/rustc-${VERSION}
	ln -svfn rustc-${VERSION} /opt/rustc


	# Configure the build
	cat << EOF > config.toml
# see config.toml.example for more possible options
# See the 8.4 book for an old example using shipped LLVM
# e.g. if not installing clang, or using a version before 13.0

# tell x.py to not keep printing an annoying warning
changelog-seen = 2

[llvm]
# by default, rust will build for a myriad of architectures
targets = "X86"

# When using system llvm prefer shared libraries
link-shared = true

[build]
# omit docs to save time and space (default is to build them)
docs = false

# install extended tools: cargo, clippy, etc
extended = true

# Do not query new versions of dependencies online.
locked-deps = true

# Specify which extended tools (those from the default install).
tools = ["cargo", "clippy", "rustfmt"]

# Use the source code shipped in the tarball for the dependencies.
# The combination of this and the "locked-deps" entry avoids downloading
# many crates from Internet, and makes the Rustc build more stable.
vendor = true

[install]
prefix = "$FAKEROOT/$NAME/opt/rustc-${VERSION}"
docdir = "share/doc/rustc-${VERSION}"

[rust]
channel = "stable"
description = "for BLFS 11.3"

# BLFS used to not install the FileCheck executable from llvm,
# so disabled codegen tests.  The assembly tests rely on FileCheck
# and cannot easily be disabled, so those will anyway fail if
# FileCheck has not been installed.
#codegen-tests = false

[target.x86_64-unknown-linux-gnu]
# NB the output of llvm-config (i.e. help options) may be
# dumped to the screen when config.toml is parsed.
llvm-config = "/usr/bin/llvm-config"

[target.i686-unknown-linux-gnu]
# NB the output of llvm-config (i.e. help options) may be
# dumped to the screen when config.toml is parsed.
llvm-config = "/usr/bin/llvm-config"
EOF

	# Compile rust
	{ [ ! -e /usr/include/libssh2.h ] ||
	  export LIBSSH2_SYS_USE_PKG_CONFIG=1; } &&
	python3 ./x.py build

	# Make sure that the rust compiler can be found by applications that need it
	cat > $FAKEROOT/$NAME/etc/profile.d/rustc.sh << "EOF"
# Begin /etc/profile.d/rustc.sh

export PATH="$PATH:/opt/rustc/bin"

# Include /opt/rustc/man in the MANPATH variable to access manual pages
export MANPATH="$MANPATH:/opt/rustc/share/man"

# End /etc/profile.d/rustc.sh
EOF

	source $FAKEROOT/$NAME/etc/profile.d/rustc.sh
}

_install()
{
	python3 ./x.py install
}
