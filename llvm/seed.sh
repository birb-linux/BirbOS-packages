NAME="llvm"
DESC="A collection of modular and reusable compiler and toolchain technologies"
VERSION="17.0.6"
MAJOR_VERSION="$(major_version $VERSION)"
SOURCE="https://github.com/llvm/llvm-project/releases/download/llvmorg-${VERSION}/llvm-${VERSION}.src.tar.xz"
CHECKSUM="fd7fc891907e14f8e0ff7e3f87cc89a4"
DEPS="cmake"
FLAGS="32bit"

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"

	println "Downloading some extra stuff that is needed to build LLVM"
	wget "https://anduin.linuxfromscratch.org/BLFS/llvm/llvm-cmake-${MAJOR_VERSION}.src.tar.xz"
	[ "$(md5sum "llvm-cmake-${MAJOR_VERSION}.src.tar.xz" | cut -d' ' -f1)" != "2b75b6446bfd5d0dcc288cd412b6a52a" ] && echo "md5 mismatch with llvm-cmake-${MAJOR_VERSION}.src.tar.xz" && exit 1

	wget "https://github.com/llvm/llvm-project/releases/download/llvmorg-${VERSION}/clang-${VERSION}.src.tar.xz"
	[ "$(md5sum "clang-${VERSION}.src.tar.xz" | cut -d' ' -f1)" != "52ff9f49e064860445474aa21e4a7e40" ] && echo "md5 mismatch with clang-${VERSION}.src.tar.xz" && exit 1

	wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${VERSION}/compiler-rt-${VERSION}.src.tar.xz
	[ "$(md5sum "compiler-rt-${VERSION}.src.tar.xz" | cut -d' ' -f1)" != "85d25f04cbc4c1a20e3a1ab2a2c522cd" ] && echo "md5 mismatch with compiler-rt-${VERSION}.src.tar.xz" && exit 1

	wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${VERSION}/clang-tools-extra-${VERSION}.src.tar.xz
	[ "$(md5sum "clang-tools-extra-${VERSION}.src.tar.xz" | cut -d' ' -f1)" != "f493311363c1f7dae40624baa7a3642e" ] && echo "md5 mismatch with clang-tools-extra-${VERSION}.src.tar.xz" && exit 1
	tar -xf clang-tools-extra-${VERSION}.src.tar.xz
	ln -sv clang-tools-extra-${VERSION}.src clang-tools-extra

	cd "${NAME}-${VERSION}.src" || exit 1
}

_build()
{
	# Extract and setup llvm-cmake
	tar -xf ../llvm-cmake-${MAJOR_VERSION}.src.tar.xz
	sed "/LLVM_COMMON_CMAKE_UTILS/s@../cmake@cmake-${MAJOR_VERSION}.src@" \
		-i CMakeLists.txt

	# Install clang into the source tree
	tar -xf ../clang-${VERSION}.src.tar.xz -C tools
	mv tools/clang-${VERSION}.src tools/clang

	# This is needed for the clang extra tools
	ln -srv tools/clang ../clang

	# Install compiler-rt into the source tree
	tar -xf ../compiler-rt-${VERSION}.src.tar.xz -C projects
	mv projects/compiler-rt-${VERSION}.src projects/compiler-rt
	ln -sr projects/compiler-rt ../compiler-rt

	# Make sure that python scripts know to call python3
	grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/'

	# Apply a clang patch that enables Stack Smash Protection by default in compiled programs
	patch -Np2 -d tools/clang < "$PKG_PATH/clang-17-enable_default_ssp-1.patch"

	# Build llvm
	mkdir -v build
	cd       build || exit 1

	CC=gcc CXX=g++            \
	cmake -DCMAKE_INSTALL_PREFIX=/usr \
		  -DLLVM_ENABLE_FFI=ON                       \
		  -DCMAKE_BUILD_TYPE=Release                 \
		  -DLLVM_BUILD_LLVM_DYLIB=ON                 \
		  -DLLVM_LINK_LLVM_DYLIB=ON                  \
		  -DLLVM_ENABLE_RTTI=ON                      \
		  -DLLVM_TARGETS_TO_BUILD="host;AMDGPU;BPF"  \
		  -DLLVM_BINUTILS_INCDIR=/usr/include        \
		  -DLLVM_INCLUDE_BENCHMARKS=OFF              \
          -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt" \
		  -DCLANG_DEFAULT_PIE_ON_LINUX=ON            \
		  -Wno-dev -G Ninja ..
	ninja
}

_install()
{
	DESTDIR="$FAKEROOT/$NAME" ninja install
	cp bin/FileCheck "$FAKEROOT/$NAME/usr/bin"
}

_build32()
{
	# Get rid of the 64bit build
	cd ..
	rm -r build
	mkdir build
	cd build || exit 1

	LDFLAGS="-L/usr/lib32" CC="gcc -m32" CXX="g++ -m32" \
	cmake -DCMAKE_INSTALL_PREFIX=/usr \
		  -DLLVM_ENABLE_FFI=ON                       \
		  -DCMAKE_BUILD_TYPE=Release                 \
		  -DLLVM_BUILD_LLVM_DYLIB=ON                 \
		  -DLLVM_LINK_LLVM_DYLIB=ON                  \
		  -DLLVM_ENABLE_RTTI=ON                      \
		  -DLLVM_TARGETS_TO_BUILD="host;AMDGPU;BPF;X86" \
		  -DLLVM_BINUTILS_INCDIR=/usr/include        \
		  -DLLVM_INCLUDE_BENCHMARKS=OFF              \
          -DLLVM_ENABLE_PROJECTS="clang-tools-extra" \
		  -DCLANG_DEFAULT_PIE_ON_LINUX=ON            \
		  -DLLVM_BUILD_32_BITS=ON                    \
		  -Wno-dev -G Ninja ..
	ninja
}

_install32()
{
	DESTDIR=$PWD/DESTDIR ninja install
	mkdir -pv "$FAKEROOT/$NAME/usr/lib32/pkgconfig"
	cp -Rv DESTDIR/usr/lib/* "$FAKEROOT/$NAME/usr/lib32"
	cp -Rv DESTDIR/usr/bin/llvm-config "$FAKEROOT/$NAME/usr/bin/llvm-config32"
	rm -rf DESTDIR
}
