#!/bin/sh
# creating config.h
hts_version="1.10.2"

# for armeabi-v7a and arm64-v8a cross compiling
toolchain_file="set path to /android-sdk-linux/ndk-bundle/build/cmake/android.toolchain.cmake"

autoheader
autoconf
chmod +x ./configure 
./configure --enable-bz2=no --enable-lzma=no --with-libdeflate=no --enable-libcurl=no  --enable-gcs=no --enable-s3=no
echo "
////////////hack////////
#ifndef PLUGIN_EXT
# define PLUGIN_EXT \".so\"
#endif" >> config.h

touch version.h
echo "#define HTS_VERSION_TEXT \"$hts_version\"" > version.h

mkdir -p build
rm -rf build
mkdir build
cd build

# for architecture x86 
# cmake .. -DDEPLOY_PLATFORM=x86
# make -j 8

# # for architecture armeabi-V7a
# cmake .. -G Ninja -DCMAKE_TOOLCHAIN_FILE:STRING=$toolchain_file -DANDROID_PLATFORM=android-21 -DDEPLOY_PLATFORM:STRING="armeabi-v7a" -DANDROID_ABI="armeabi-v7a"
# ninja

# # for architecture arm66-v8a
cmake .. -G Ninja -DCMAKE_TOOLCHAIN_FILE:STRING=$toolchain_file -DANDROID_PLATFORM=android-21 -DDEPLOY_PLATFORM:STRING="arm64-v8a" -DANDROID_ABI="arm64-v8a"
ninja