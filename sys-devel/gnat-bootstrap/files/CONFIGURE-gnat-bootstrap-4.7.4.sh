#!/bin/sh

../gcc-4.7.4/configure CFLAGS='-O' --enable-languages=c,c++,ada --disable-shared --with-boot-ldflags='-static -static-libgcc -static-libstdc++' --with-boot-libs='-static -lc -lm' --disable-lto --disable-libquadmath --disable-nls --prefix=/opt/gnat-bootstrap-4.7
