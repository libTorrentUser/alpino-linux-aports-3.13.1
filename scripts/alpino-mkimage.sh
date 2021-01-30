#!/bin/sh

# usage 
# alpine-mkimage.sh alpine-initialize-dir profile
#
# ex:
#
# build a standard Alpine Linux and copy all files from /tmp/somedir to /ali
# alpino-mkimage.sh /tmp/somedir/ standard

# build a virt Alpine Linux image and copy all files from /dir/a to /ali
# alpino-mkimage.sh /dir/a virt



# first we ensure our customized version of alpine-baselayout is built. The
# modified inittab file is there, and it is pretty much the most important 
# change we made. It is the inittab file the one that calls the user defined
# initialization script (the ali/init.sh file)
cd ../main/alpine-baselayout
abuild


# update /sbin/update-kernel so we can pass aditional compression options to the
# mkquashfs call that will be done when generating the ISO
sudo sed -i 's/-comp xz -exit-on-error/-comp xz \$_alpinoSquashFsOptions -exit-on-error/' /sbin/update-kernel
export _alpinoSquashFsOptions="-b 1M -Xdict-size 100% -Xbcj x86";

# get the version and then extract only the major.minor digits, because that is
# what goes inside the official repositories URLs
_version=$(grep 'pkgver=' ../alpine-base/APKBUILD)
_version=$(echo $_version | sed 's/.*=\([0-9]\+.[0-9]\+\).*/\1/')

# and now use that version to create the URL
_officialRepositoryURL="http://dl-cdn.alpinelinux.org/alpine/v${_version}"

# finally, build the live image
cd ../../scripts
./mkimage.sh \
	--ali-dir "$1" \
	--profile "$2" \
	--outdir /tmp/iso \
	--workdir /tmp/work \
	--repository /tmp/packages/main \
	--repository "${_officialRepositoryURL}/main" \
	--repository "${_officialRepositoryURL}/community" \
	--arch x86_64

